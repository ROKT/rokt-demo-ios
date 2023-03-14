#!/bin/bash
source /Users/ec2-user/.rvm/scripts/rvm
rvm osx-ssl-certs update all
rvm use ruby-2.7.6@ios-demo --create
bundle install
pod install --verbose