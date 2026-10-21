import hashlib
from pathlib import Path
import plistlib
import subprocess
import tempfile
import unittest
from unittest.mock import patch
import zipfile

from release_metadata import check_release, github_json, read_metadata


class ReleaseMetadataTests(unittest.TestCase):
    def setUp(self):
        directory = tempfile.TemporaryDirectory()
        self.addCleanup(directory.cleanup)
        self.ipa = Path(directory.name) / "RoktDemo.ipa"
        self.version_file = Path(directory.name) / "VERSION"
        self.version_file.write_text("5.5.5\n")

    def write_ipa(
        self,
        version="5.5.5",
        build="374",
        fmt=plistlib.FMT_BINARY,
        names=("Payload/RoktDemo.app/Info.plist",),
    ):
        info = {"CFBundleShortVersionString": version, "CFBundleVersion": build}
        with zipfile.ZipFile(self.ipa, "w") as archive:
            for name in names:
                archive.writestr(name, plistlib.dumps(info, fmt=fmt))

    def test_reads_resolved_binary_and_xml_plists(self):
        for fmt in (plistlib.FMT_BINARY, plistlib.FMT_XML):
            with self.subTest(fmt=fmt):
                self.write_ipa(fmt=fmt)
                self.assertEqual(
                    read_metadata(self.ipa, self.version_file),
                    {"version_name": "5.5.5", "build_number": "374"},
                )

    def test_rejects_placeholders_missing_and_malformed_values(self):
        for version, build in (
            ("$(MARKETING_VERSION)", "374"),
            ("5.5.5", "$(CURRENT_PROJECT_VERSION)"),
            ("", "374"),
            ("5.5.5", ""),
            ("5.5.5\ntag=other", "374"),
            (555, "374"),
        ):
            with self.subTest(version=version, build=build):
                self.write_ipa(version, build)
                with self.assertRaises(ValueError):
                    read_metadata(self.ipa, self.version_file)
        with zipfile.ZipFile(self.ipa, "w") as archive:
            archive.writestr("Payload/RoktDemo.app/Info.plist", plistlib.dumps({}))
        with self.assertRaises(ValueError):
            read_metadata(self.ipa, self.version_file)

    def test_rejects_version_mismatch(self):
        self.write_ipa(version="5.5.0")
        with self.assertRaisesRegex(ValueError, "does not match VERSION"):
            read_metadata(self.ipa, self.version_file)

    def test_requires_one_top_level_app_ignoring_framework_plists(self):
        app = "Payload/RoktDemo.app/Info.plist"
        framework = "Payload/RoktDemo.app/Frameworks/Example.framework/Info.plist"
        self.write_ipa(names=(app, framework))
        self.assertEqual(
            read_metadata(self.ipa, self.version_file)["version_name"], "5.5.5"
        )
        for names in ((framework,), (app, "Payload/Other.app/Info.plist")):
            with self.subTest(names=names):
                self.write_ipa(names=names)
                with self.assertRaisesRegex(ValueError, "exactly one"):
                    read_metadata(self.ipa, self.version_file)

    @patch("release_metadata.github_json")
    def test_new_release_and_existing_tag_on_same_commit(self, api):
        api.side_effect = [None, None]
        self.assertFalse(check_release("example/demo", "5.5.5", "source", self.ipa))
        api.side_effect = [{"object": {}}, {"sha": "source"}, None]
        self.assertFalse(check_release("example/demo", "5.5.5", "source", self.ipa))

    @patch("release_metadata.github_json")
    def test_rejects_tag_on_another_commit(self, api):
        api.side_effect = [{"object": {}}, {"sha": "other"}]
        with self.assertRaisesRegex(ValueError, "another commit"):
            check_release("example/demo", "5.5.5", "source", self.ipa)

    @patch("release_metadata.github_json")
    def test_only_skips_published_release_with_identical_asset(self, api):
        self.write_ipa()
        digest = "sha256:" + hashlib.sha256(self.ipa.read_bytes()).hexdigest()
        for assets, draft, expected in (
            ([{"name": self.ipa.name, "digest": digest}], False, True),
            ([{"name": self.ipa.name, "digest": "sha256:other"}], False, False),
            ([], False, False),
            ([], True, False),
        ):
            with self.subTest(assets=assets, draft=draft):
                api.side_effect = [
                    {"object": {}},
                    {"sha": "source"},
                    {"draft": draft, "prerelease": False, "assets": assets},
                ]
                if expected:
                    self.assertTrue(
                        check_release("example/demo", "5.5.5", "source", self.ipa)
                    )
                else:
                    with self.assertRaises(ValueError):
                        check_release("example/demo", "5.5.5", "source", self.ipa)

    @patch("release_metadata.subprocess.run")
    @patch("release_metadata.github_json")
    def test_downloads_legacy_asset_to_verify_checksum(self, api, run):
        self.write_ipa()
        api.side_effect = [
            {"object": {}},
            {"sha": "source"},
            {"draft": False, "prerelease": False, "assets": [{"name": self.ipa.name}]},
        ]

        def download(command, **kwargs):
            Path(command[-1]).write_bytes(self.ipa.read_bytes())

        run.side_effect = download
        self.assertTrue(check_release("example/demo", "5.5.5", "source", self.ipa))

    @patch("release_metadata.subprocess.run")
    def test_only_treats_http_404_as_missing(self, run):
        for status, returncode, body in (
            (200, 0, '{"sha":"source"}'),
            (404, 1, "{}"),
            (403, 1, "{}"),
            (500, 1, "{}"),
        ):
            with self.subTest(status=status):
                run.return_value = subprocess.CompletedProcess(
                    [],
                    returncode,
                    f"HTTP/2.0 {status} Status\nContent-Type: application/json\n\n{body}",
                    "error",
                )
                if status == 200:
                    self.assertEqual(
                        github_json("example/demo", "commits/tag"), {"sha": "source"}
                    )
                elif status == 404:
                    self.assertIsNone(github_json("example/demo", "commits/tag"))
                else:
                    with self.assertRaises(ValueError):
                        github_json("example/demo", "commits/tag")


if __name__ == "__main__":
    unittest.main()
