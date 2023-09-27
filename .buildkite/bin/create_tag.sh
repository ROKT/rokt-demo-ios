#!/bin/bash

set -eu

# $1 version

git config user.email "buildkite@rokt.com"
git config user.name "Buildkite"

git tag -d "v$1" || true
git add Podfile
git add Podfile.lock
git add RoktDemo.xcodeproj/project.pbxproj
git commit -m "v$1"
git tag -a "v$1" -m "Automated release v$1"
git push origin "v$1"