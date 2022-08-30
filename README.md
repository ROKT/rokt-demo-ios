# rokt-demo-ios
Rokt Demo application is a sample app built to showcase Rokt SDK functionality.

## Requirements

XCode 13 and above. Project is configured to run on iOS 13.0 and above.

## Project architecture

This project it is implemented based on MVVM pattern with SwiftUI. 
MVVM stands for Model-View-ViewModel, an architecture pattern that is structured to separate program logic and user interface controls. It has Model, View and ViewModel separation. 

This project contains UI, Model, Services, Utils and Resources groups.

UI: View and ViewModels are located in the UI Group.

Services & Model: Services represent the network logics of the application and model represnts the data.

Utils: are shared between Groups of the application.

Resources: All the other resources of the application is located in Resources. 

![UI diagram](diagram.png)

## Where to start

As it is defined on SceneDelegate, the starting point of the application is HomePageView located in `UI/Home` folder.

## How to release the app
- Update `Version` and `Build` in RoktDemo target
- Commit & push and merge it to the release branch
- Aprove the **hold** on **[CircleCI](https://circleci.com/)** and wait till it finished
- Follow the instructions on itunesconnect

## FAQ

### How to setup the environment?
- run `Pod install` on the main folder of iOS application where podfile exists.

### What are the versions?

* **release 1.x** - The first version of Demo application
* **release 1.1.x** - The PreDefined brand demos added

### What are the branches?

here are main branches coresponding to each version : **Master**, **Release branches** and **Features branches**

* **master** - Master branch which corrently is not used
* **release branches** - Prod environment. After every push to this branch tests are run to ensure no breaking changes are allowed and after approval. Releasing to TestFlight could be enabled after all the tests passes. 
* **feature branches** - After every push to this branch swift lint and tests are run to ensure no breaking changes are allowed.

### How to run tests locally?

Select the RoktDemo scheme and press command + U, or Product -> Test.
Tests can be found in `RoktDemoTests` and `RoktDemoUIITests`.

### How to run tests on CircleCI?

Just push a change to any of the branches and tests will be run. The result of the test would be visible in the [CircleCi](https://circleci.com/).

### Something is not working, what do I do?

In case you run into any problems you can try:

* Clean the build folder of the project. Select menu: Product -> Clean Build Folder

### Where are dependencies defined?

All project dependencies are defined on the podfile. Cocoapods used as dependency manager of this repository. The full description of Cocoapods could be find here [here](https://cocoapods.org/)

## License

Copyright 2020 Rokt Pte Ltd

Licensed under the Rokt Software Development Kit (SDK) Terms of Use
Version 2.0 (the "License")

You may not use this file except in compliance with the License.

You may obtain a copy of the License at https://rokt.com/sdk-license-2-0/