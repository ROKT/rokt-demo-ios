#!/usr/bin/env bash
bash --version
eval "$(rbenv init -)"
rbenv local 2.7.6
gem install bundler
bundle install
xcrun simctl boot "iPhone 14"
pod install --verbose
bundle exec fastlane test
xcrun simctl shutdown "iPhone 14" || true
