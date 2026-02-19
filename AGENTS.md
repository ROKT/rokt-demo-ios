# rokt-demo-ios

## Project Overview

The Rokt Demo iOS app is a sample application built to showcase
[Rokt SDK](https://docs.rokt.com/docs/developers/integration-guides/ios/overview)
functionality on iOS. It demonstrates how Rokt's partners generate stronger
revenue outcomes by providing a more personalized experience for each customer at
scale, including placement demos with pre-defined brands, layout previews via QR
code scanning, and deep-link-driven layout rendering.

**Bundle ID:** `com.rokt.RoktDemo`
**Cortex tag:** `native-demo-ios`
**Owner:** sdk-engineering
**On-call:** Mobile Integrations (OpsGenie schedule)
**Service tier:** 3

## Architecture

The app follows the **MVVM** (Model-View-ViewModel) pattern using **SwiftUI**.

```text
AppDelegate (entry point, sets Rokt environment)
  └── SceneDelegate
        └── HomePageView (root SwiftUI view)
              ├── Placement Demo (DemoLibraryView) ── brand demos via API
              ├── Layout Demo — SwiftUI (LayoutDemoView) ── QR code / deep-link preview
              ├── Layout Demo — UIKit (LayoutDemoUIView) ── UIKit wrapper for layout preview
              ├── About (AboutRoktView) ── "About Rokt" content from API
              └── Settings (SettingView) ── toggle Stage/Prod environment
```

**Data flow:**

- `NetworkService` (Alamofire) makes HTTP calls to the demo API server
  (`https://rokt-demo-app-server.rokt.com/`).
- `DemoLibraryService` and `AboutRoktService` use `NetworkService` to fetch
  demo library items and about content.
- ViewModels publish state via `@Published` / Combine `Future`.
- `Rokt_Widget` SDK is initialized with a tag ID and used to render placements
  and layouts.
- Deep links (`rokt://` URL scheme) pass a `config` query parameter that is
  decoded and rendered as a layout preview.

## Tech Stack

| Component | Detail |
|---|---|
| Language | Swift (SwiftUI + UIKit) |
| Min deployment target | iOS 13.0 |
| Xcode | 16.4 (CI runner: `macos-15`) |
| Dependency management | Swift Package Manager (SPM) |
| Build automation | Fastlane 2.220.0 (via Bundler / Gemfile) |
| HTTP networking | Alamofire |
| Image loading | SDWebImageSwiftUI |
| QR code scanning | CodeScanner |
| Rokt SDK | Rokt-Widget (via SPM, from `ROKT/rokt-sdk-ios`) |
| Ruby tooling | Bundler 2.5.6, CocoaPods 1.15.2 (legacy, SPM is primary) |

## Development Guide

### Prerequisites

- macOS with Xcode 15+ (16.4 recommended to match CI)
- Ruby (for Fastlane) — install via `bundle install`

### Quick Start

1. Open `RoktDemo.xcodeproj` in Xcode.
2. File -> Packages -> Reset Package Caches.
3. File -> Packages -> Resolve Package Versions.
4. Select the `RoktDemo` scheme and click Run.

### Pointing to a Specific Rokt SDK Version

- In Xcode: Project navigator -> RoktDemo target -> Package Dependencies ->
  find `rokt-sdk-ios` -> change version.
- Or edit `minimumVersion` in `RoktDemo.xcodeproj/project.pbxproj`.

### Running Tests

Select the `RoktDemo` scheme and press `Cmd + U`, or Product -> Test.

- Unit tests: `RoktDemoTests/`
- UI tests: `RoktDemoUITests/`

### Troubleshooting

- Clean the build folder: Product -> Clean Build Folder in Xcode.

## Build, Test & Lint Commands

### Fastlane Lanes

| Lane | Description |
|---|---|
| `fastlane test` | Runs all tests on iPhone 15 simulator |
| `fastlane certificates` | Installs signing certificates/profiles via Match |
| `fastlane beta` | Builds and pushes a beta to TestFlight |

### Xcode CLI (used in CI)

```bash
# Archive
xcodebuild -project RoktDemo.xcodeproj \
  -scheme RoktDemo \
  -configuration Release \
  -archivePath build/RoktDemo.xcarchive \
  archive

# Export IPA
xcodebuild -exportArchive \
  -archivePath build/RoktDemo.xcarchive \
  -exportOptionsPlist ExportOptions.plist \
  -exportPath build
```

## CI/CD Pipeline

CI runs on **GitHub Actions** with `macos-15` runners. Xcode 16.4 is set up via
the `.github/actions/setup-xcode` composite action.

### Workflows

| Workflow | Trigger | Description |
|---|---|---|
| `release-from-main.yml` | Push to `main` when `VERSION` file changes | Builds IPA, uploads to Firebase App Distribution, creates GitHub release with tag |
| `distribute-to-firebase.yml` | Manual (`workflow_dispatch`) | Builds IPA and distributes to Firebase App Distribution testers |
| `trigger-release-to-firebase.yml` | `repository_dispatch: release-build` | Updates SPM package version + Xcode version, creates a PR to `main` |
| `trigger-snapshot-to-firebase.yml` | `repository_dispatch: snapshot-build` | Updates SPM package version, builds and distributes snapshot to Firebase |
| `pr-notification.yml` | PR opened/reopened | Sends notification to Google Chat via shared workflow |

### Composite Actions

| Action | Purpose |
|---|---|
| `build-ipa` | Sets up Xcode, keychain, provisioning profile; archives and exports IPA |
| `setup-xcode` | Installs Xcode 16.4 via `maxim-lobanov/setup-xcode` |
| `update-spm-package` | Updates `minimumVersion` for `rokt-sdk-ios` in `project.pbxproj` |
| `upload-ipa` | Authenticates with Google Cloud and uploads IPA to Firebase App Distribution |

### Release Process

1. Update `Version` and `Build` in the RoktDemo Xcode target.
2. Commit and push to `main`.
3. Dispatch "Distribute to Firebase" workflow from GitHub Actions, or use the
   Mobile Release Pipeline.
4. Testers in the `TESTING_GROUPS` secret receive the new build via Firebase.

## Environment Variables

| Variable | Used In | Description |
|---|---|---|
| `APPSTORE_KEY_ID` | Fastlane | App Store Connect API key ID |
| `APPSTORE_ISSUER_ID` | Fastlane | App Store Connect API issuer ID |
| `APPSTORE_KEY_CONTENT_B64` | Fastlane | Base64-encoded App Store Connect API key |
| `MATCH_GIT_URL` | Fastlane | Git URL for Match certificates repo |
| `MATCH_GIT_BRANCH` | Fastlane | Branch in Match certificates repo |
| `MATCH_USERNAME` | Fastlane | Apple Developer account username |
| `MATCH_GIT_USER_EMAIL` | Fastlane | Git user email for Match |
| `DEVELOPMENT_TEAM_ID` | Fastlane | Apple Development Team ID |
| `MPARTICLE_ENTERPRISE_CERTIFICATE_P12_BASE64` | GitHub Actions | Base64-encoded enterprise signing certificate |
| `MPARTICLE_ENTERPRISE_CERTIFICATE_PASSPHRASE` | GitHub Actions | Certificate passphrase |
| `MPARTICLE_ENTERPRISE_PROVISIONING_PROFILE_BASE64` | GitHub Actions | Base64-encoded provisioning profile |
| `SERVICE_ACCOUNT` | GitHub Actions | Google Cloud service account JSON |
| `WORKLOAD_IDENTITY_PROVIDER` | GitHub Actions | Google Cloud workload identity provider |
| `FIREBASE_APP_ID` | GitHub Actions | Firebase App Distribution app ID |
| `TESTING_GROUPS` | GitHub Actions | Firebase testing groups for distribution |
| `SDK_RELEASE_GITHUB_APP_ID` | GitHub Actions | GitHub App ID for automated release PRs |
| `SDK_RELEASE_GITHUB_APP_PRIVATE_KEY` | GitHub Actions | GitHub App private key |
| `GCHAT_PRS_WEBHOOK` | GitHub Actions | Google Chat webhook for PR notifications |

## Project Structure

```text
RoktDemo.xcodeproj/        Xcode project (SPM dependencies defined here)
RoktDemo/
  Info.plist               App metadata, URL schemes, permissions
  Model/                   Data models (AboutRokt, DemoLibrary, Layouts)
  Service/                 Network and business logic services
    NetworkService.swift   Alamofire-based generic HTTP client
    DemoLibraryService.swift  Fetches demo library data
    AboutRoktService.swift    Fetches about content
    ValidationService.swift   Input validation helpers
  UI/
    Home/                  Home page (root view)
    Placement Demo/        Pre-defined brand demos, custom account/customer flows
    Layout Demo/           QR code scan and layout preview (SwiftUI + UIKit)
    About/                 About Rokt content views
    Setting/               Stage/Prod environment toggle
    Common/                Shared views, navigation bars, extensions, buttons
    State/                 UI state enums
  Utils/                   Constants, extensions, helpers
  Resources/               AppDelegate, SceneDelegate, assets, fonts, launch screen
RoktDemoTests/             Unit tests (XCTest)
RoktDemoUITests/           UI tests (XCTest)
fastlane/                  Fastlane configuration
  Fastfile                 Test, certificates, and beta lanes
  Matchfile                Code signing via Match (app-store type)
  Appfile                  App identifier config (placeholder)
  Deliverfile              App Store delivery config
ExportOptions.plist        Enterprise export options for IPA
VERSION                    Current app version (4.16.1)
.cortex/catalog/           Cortex service catalog definition
.github/
  workflows/               GitHub Actions CI/CD workflows
  actions/                 Reusable composite actions
  CODEOWNERS               @ROKT/sdk-engineering
  pull_request_template.md PR template
```

## Observability

- **Datadog dashboard:** [Mobile SDK Detailed Error View](https://rokt.datadoghq.com/dashboard/nsi-c8c-gtd)
- **Cortex service name:** `native-demo-ios`

## Team Ownership

- **CODEOWNERS:** `@ROKT/sdk-engineering`
- **Cortex group:** `sdk-engineering`
- **Resident experts:** James Newman, Thomson Thomas

## Maintaining This Document

When making changes to this repository that affect the information documented here
(build commands, dependencies, architecture, deployment configuration, etc.),
please update this document to keep it accurate. This file is the primary reference
for AI coding assistants working in this codebase.
