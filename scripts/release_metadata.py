"""Validate the built app's version and check whether it is already published."""

import argparse
import hashlib
import json
import os
from pathlib import Path
import plistlib
import re
import subprocess
import tempfile
from urllib.parse import quote
import zipfile


def read_metadata(ipa, version_file):
    with zipfile.ZipFile(ipa) as archive:
        plists = [
            name
            for name in archive.namelist()
            if re.fullmatch(r"Payload/[^/]+\.app/Info\.plist", name)
        ]
        if len(plists) != 1:
            raise ValueError("The IPA must contain exactly one app Info.plist")
        info = plistlib.loads(archive.read(plists[0]))
    version = info.get("CFBundleShortVersionString")
    build = info.get("CFBundleVersion")
    if not isinstance(version, str) or not re.fullmatch(
        r"[0-9]+\.[0-9]+\.[0-9]+", version
    ):
        raise ValueError("The IPA must contain a resolved numeric app version")
    if not isinstance(build, str) or not re.fullmatch(
        r"[0-9]+(?:\.[0-9]+){0,2}", build
    ):
        raise ValueError("The IPA must contain a resolved numeric build number")
    if version != Path(version_file).read_text().strip():
        raise ValueError(f"IPA version {version} does not match VERSION")
    return {"version_name": version, "build_number": build}


def github_json(repository, path):
    result = subprocess.run(
        ["gh", "api", "--include", f"repos/{repository}/{path}"],
        capture_output=True,
        text=True,
        check=False,
    )
    headers, separator, body = result.stdout.partition("\n\n")
    status = headers.splitlines()[0].split()[1] if separator else None
    if status == "404":
        return None
    if result.returncode or status != "200":
        raise ValueError(f"GitHub lookup failed for {path}: {result.stderr.strip()}")
    return json.loads(body)


def check_release(repository, version, commit, ipa):
    tag = quote(version, safe="")
    ref = github_json(repository, f"git/ref/tags/{tag}")
    if ref:
        # The commits endpoint also resolves annotated tags to their source commit.
        tagged_commit = github_json(repository, f"commits/{tag}")
        if not tagged_commit or tagged_commit["sha"] != commit:
            raise ValueError(f"Tag {version} already points to another commit")
    release = github_json(repository, f"releases/tags/{tag}")
    if release is None:
        return False
    if not ref or release["draft"] or release["prerelease"]:
        raise ValueError(
            f"Release {version} is incomplete or is not a stable release; inspect it before retrying"
        )
    assets = [asset for asset in release["assets"] if asset["name"] == ipa.name]
    if len(assets) != 1:
        raise ValueError(f"Release {version} has no unique {ipa.name} asset")
    digest = "sha256:" + hashlib.sha256(ipa.read_bytes()).hexdigest()
    published_digest = assets[0].get("digest")
    if not published_digest:
        # Older release assets may have no digest in the API response.
        with tempfile.TemporaryDirectory() as directory:
            downloaded = Path(directory) / ipa.name
            subprocess.run(
                [
                    "gh",
                    "release",
                    "download",
                    version,
                    "--repo",
                    repository,
                    "--pattern",
                    ipa.name,
                    "--output",
                    str(downloaded),
                ],
                check=True,
            )
            published_digest = (
                "sha256:" + hashlib.sha256(downloaded.read_bytes()).hexdigest()
            )
    if published_digest != digest:
        raise ValueError(
            f"Release {version} contains a different IPA; published assets will not be replaced"
        )
    return True


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("ipa", type=Path)
    parser.add_argument("version_file", type=Path)
    parser.add_argument("--check-release", action="store_true")
    args = parser.parse_args()
    try:
        metadata = read_metadata(args.ipa, args.version_file)
        exists = args.check_release and check_release(
            os.environ["GITHUB_REPOSITORY"],
            metadata["version_name"],
            os.environ["GITHUB_SHA"],
            args.ipa,
        )
        metadata["release_exists"] = str(bool(exists)).lower()
        output = "".join(f"{key}={value}\n" for key, value in metadata.items())
        if os.environ.get("GITHUB_OUTPUT"):
            with open(os.environ["GITHUB_OUTPUT"], "a") as destination:
                destination.write(output)
        print(output, end="")
    except (
        OSError,
        ValueError,
        KeyError,
        zipfile.BadZipFile,
        plistlib.InvalidFileException,
        subprocess.CalledProcessError,
    ) as error:
        parser.exit(1, f"Release validation failed: {error}\n")


if __name__ == "__main__":
    main()
