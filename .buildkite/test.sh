#!/bin/sh
. ~/.zshrc
rbenv local 2.7.6
gem install bundler

echo "Running bundle install..."
bundle install

echo "Starting iphone simulator..."
xcrun simctl boot "iPhone 14"

echo "Running cocoapod install..."
pod install --verbose

echo "Running bundle exec..."
bundle exec fastlane test

echo "Shutting down iphone 14"
xcrun simctl shutdown "iPhone 14" || true
