# rokt-demo-ios
Rokt Demo application is a sample app built to showcase Rokt SDK functionality.

## Requirements

XCode 13 and above. Project is configured to run on iOS 13.0 and above.

## Project architecture

This project it is implemented based on MVVM pattern with SwiftUI.
It contains UI, Model, Services and Utils 

## Where to start

As it is defined on SceneDelegate, the starting point of the application is HomePageView located in `UI/Home` folder.

## How to release the app
- Update `Version` and `Build` in RoktDemo target
- Commit & push
- Unblock the release step on **CircleCI**
- Follow the instructions on itunesconnect

## FAQ

### How to setup the environment?
- run `Pod install`

### What are the versions?

* **version 1.x** - The first version of Demo application
* **version 1.1.x** - The Brand demos added

### How to run tests locally?

Select the RoktDemo scheme and press command + U, or Product -> Test.
Tests can be found in `RoktDemoTests` and `RoktDemoUIITests`.

### How to run tests on CircleCI?

Just push a change to any of the branches and tests will be run.

### How do I submit a new test build of the example app to TestFlight?

1. Open CircleCI and select the branch
2. Aprove the hold on *hold* and wait till it finished
3. Follow the instructions on itunesconnect

### Something is not working, what do I do?

In case you run into any problems you can try:

* Clean project: Product -> Clean

### Where are dependencies defined?
Cocoapods used as dependency manager of this repository. All project dependencies are defined on the podfile

## License

Copyright 2020 Rokt Pte Ltd

Licensed under the Rokt Software Development Kit (SDK) Terms of Use
Version 2.0 (the "License")

You may not use this file except in compliance with the License.

You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/