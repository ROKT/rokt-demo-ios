#!/usr/bin/env bash
bash --version
. /Users/ec2-user/.bashrc
rbenv local 2.7.6
gem install bundler
bundle install
xcrun simctl boot "iPhone 14"
pod install --verbose
bundle exec fastlane test
xcrun simctl shutdown "iPhone 14" || true
