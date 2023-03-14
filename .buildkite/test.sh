#!/bin/bash
source /Users/ec2-user/.rvm/scripts/rvm
rvm osx-ssl-certs update all
rvm use ruby-2.7.6@ios-demo --create
bundle install
xcrun simctl boot "iPhone 14"
pod install --verbose
bundle exec fastlane test
xcrun simctl shutdown "iPhone 14" || true
