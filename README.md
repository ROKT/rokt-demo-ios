# rokt-demo-ios
Rokt Demo application is a sample app built to showcase Rokt SDK functionality.

## Requirements

XCode 13 and above. Project is configured to run on iOS 13.0 and above.

## Project architecture

This project it is implemented based on MVVM pattern with SwiftUI.
It contains UI, Model, Services, Utils and Resources
View and ViewModels are located in the UI Group.
Services represents the network logics of the application and model represnts the data.
Utils are shared between Groups of the application
All the other resources of the application is located in Resources. 

## Where to start

As it is defined on SceneDelegate, the starting point of the application is HomePageView located in `UI/Home` folder.

## How to release the app
- Update `Version` and `Build` in RoktDemo target
- Commit & push and merge it to the release branch
- Aprove the **hold** on **CircleCI** and wait till it finished
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