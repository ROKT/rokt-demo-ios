#!/bin/bash

set -eu

# $1 iOS SDK version
# $2 Podfile location
# $3 Demo app version
# $4 Demo app build number
# $5 Project file location

perl -pi -e "s/(?<='Rokt-Widget', '~> )(.*)(?=')/$1/g" $2
perl -pi -e "s/(?<=MARKETING_VERSION = )(.*)(?=;)/$3/g" $5
perl -pi -e "s/(?<=CURRENT_PROJECT_VERSION = )(.*)(?=;)/$4/g" $5
pod install --repo-update