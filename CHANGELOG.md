<!-- markdownlint-disable MD024 -->

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Shoppable Ads demo with Stripe payment integration
- Custom placement builder for Shoppable Ads (account setup, attributes, execution)
- RoktPaymentExtension SPM dependency
- Pre-populated default attributes for easy Shoppable Ads testing
- SDK event logging in Shoppable Ads execution view
- Shoppable Ads-specific disclaimer in placement summary

### Changed

- The About and Placement Library screens show content bundled in the app; the demo app server is no longer called, and its address leaves the constants
- The Custom placement builder no longer asks for a password; it initializes the SDK with the entered account ID
