#!/bin/bash

set -eu

# $1 version
# $2 version code

git config user.email "buildkite@rokt.com"
git config user.name "Buildkite"

git tag -d "v$1-$2" || true
git add Podfile
git add Podfile.lock
git add RoktDemo.xcodeproj/project.pbxproj
git commit -m "v$1"
git tag -a "v$1-$2" -m "Automated release v$1-$2"
git push origin "v$1-$2"