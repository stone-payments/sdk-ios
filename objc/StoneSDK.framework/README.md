# iOS Payment SDK

![Objective-C](https://img.shields.io/badge/Linguagem-Objective--c-blue.svg) ![Objective-C](https://img.shields.io/badge/iOS-v8.4+-blue.svg)

A 'White Label' integration developed to establish communication between iOS devices and ABECS pinpads.

Its main goal is to enable iOS mobile solutions to provide direct payment on their platform via credit card, debit and voucher transactions

- [Documentation](#documentation)
- [Project settings](#project-settings)
- [Release](#new-version-release)


## Documentation

Detailed documentation about the use of this SDK can be found at the [Stone website](http://sdkios.stone.com.br/v1.0/docs) or at the [Github Demo](https://github.com/stone-payments/sdk-ios-v2).


## Project settings

#### Developing language

This project is written in Objective-c so that it can assure full compatibility with both Objective-c and Swift projects.

#### Avoid third-party libraries

When adding third-party code as libraries, we can't guarantee it's stability.

#### Universal build run script

At the project settings, on `Build Phases > Run Script`, there's a run script that generate builds on derived data for iphoneos and iphonesimulator. This allows users of the SDK to run it on both device and simulator with the same SDK build.

This script is saved under `PROJECT_DIR > Scripts > build_universal.sh`.

## New version release

Today the releases are made manually. When a new version is ready to go, follow this steps to release it:

#### 1) Add version tag

Once the new version code is merged with the master branch, push the new version tag to Github. The tag matches the project version.

#### 2) Build under Release scheme

> ⚠️ Clean the project every time before building it, by going to `Product > Clean` or by pressing `Shift + Command + K`.

> There's a problem introduced with XCode 9 where the run script used to generate all needed architectures will generate a Build Failure after the first build. This failure is NOT reported by XCode as an alert: it will only appear at the build log, but the build won't be generated.

Go to `Product > Scheme > Edit Scheme > Run > Info` and change the `Build Configuration` to `Release`. Then build the project with `Command + B` or at `Product > Build`.

#### 3) Compress the build

At the project root folder, go to `Build > Release` and check if the `StoneSDK.framework` is the latest build (you can do so by checking the file modified date).
Compress this file and rename the `StoneSDK.framework.zip` to `StoneSDK_version.number.zip` (e.g. `StoneSDK_2.3.0.zip`).

#### 4) Upload the build to Github

To release a new version, go to the [releases tab](https://github.com/stone-payments/sdk-ios-v2/releases) under the [iOS SDK Demo](https://github.com/stone-payments/sdk-ios-v2) at Github and click on `Draft a new release`.
Enter the `Tag version` that matches the tag uploaded to this project and attach the `StoneSDK_version.number.zip` from the last step. The `Release title` is the same as the `Tag version`.

#### 5) Write the changelog

Under the `Describe this release` box, write the Changelog from this version. There should be both a Brazilian Portuguese and an English version. Add a flag emoji on the top of each version to separate them (🇧🇷 and 🇬🇧). You can check older releases to see how it should be done.

#### 6) Publish the release

Click on `Publish release`.

> If this is a Release-Candidate, check the `This is a pre-release` box, otherwise leave it unchecked.

#### 7) Update the Demo

When releasing a new version, make sure to update all documentations accordingly. If the usage changes, update also the Demo project.
