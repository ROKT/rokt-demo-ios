#!/usr/bin/env bash
bash --version
rbenv global 2.7.6
bundle install
xcrun simctl boot "iPhone 14"
pod install --verbose
bundle exec fastlane test
xcrun simctl shutdown "iPhone 14" || true
