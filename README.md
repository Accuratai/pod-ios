# Accurat SDK #

This repository contains the cocoapod for the Accurat SDK

## What is this repository for? ##
* Requirements
* Configure project
* Add SDK to project
* Integrate SDK into app
* GDPR
* Changelog

## Requirements

- iOS 8.0+
- Xcode 8.3+
- Swift 4+

## Configure project

Add appropriate location usage descriptions to the `Info.plist` of your application. **Be sure to fill in your app name where appropriate (or edit the string as you see fit)**

For **Xcode 9:**
```xml
<key>NSLocationAlwaysUsageDescription</key>
<string>[App_name] would like to access location.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>[App_name] would like to access location.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>[App_name] would like to access location.</string>
```

## Add SDK to project

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Accurat into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Accurat', :git => 'https://gitlab.com/accuratai/pod-ios'
end
```

Then, run the following command:

```bash
$ pod install
```

## Integrate SDK into app

### Import the SDK

```swift
import Accurat
```

### Initialize SDK
In the AppDelegate, start by configuring the username + password with the configure method:
```swift
Accurat.shared.initialize(username: "ACCURAT_USERNAME", password: "ACCURAT_PASSWORD")
```
### Start Tracking
To start Accurat, call the startTracking method (also starts the consent flow, see GDPR):
```swift
Accurat.shared.startTracking()
```
### Stop Tracking
To stop Accurat, call the stopTracking method:
```swift
Accurat.shared.stopTracking()
```
### Is tracking enabled?
If you want to know if the tracking is enabled or not, call the isTrackingEnabled variable:
```swift
Accurat.shared.isTrackingEnabled
```
### Set language
If you want to change the language of the consent popups, you can update the language. When no language is, the device language is used
```swift
Accurat.shared.setLanguage(.en/.nl/.fr)
```

### Additional location updates via Background Fetch
If you would like more periodic location updates, you can enable background fetch to allow the application to poll for location updates periodically.

Ensure that `Background Fetch` mode is enabled in your project

Additionally, implement the following method in your `AppDelegate`

```swift
func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
     Accurat.shared.performBackgroundFetchWithCompletionHandler(completionHandler)
}
```

## GDPR

### Start consent flow
If you want to start the consent flow separately from the tracking, call the askConsents method (also started by the tracking):
```swift
Accurat.shared.askConsents(onComplete: onComplete)
```

### Get consent state
If you want to get the state of a consent, call the getConsentState method and provide a consent type:
```swift
Accurat.shared.getConsentState(.tracking)
```

### Update consent state
If you want to update the state of a consent, call the updateConsent method and provide a consent type + state:
```swift
Accurat.shared.updateConsent(.tracking, state: 0/1)
```

## Changelog

### v1.0.3 - 13/07/2018
* Bugfixes
* Updated the context of the locations

### v1.0.2 - 13/07/2018
* Bugfixes
* Updated the userconsent state so that it accepts integers as a state value
* Pass platform to the GET consent api call
* Use ios_transmission_interval instead of the transmission_interval of the GET settings
* Made the img tag clickable
* The refuse button has a less striking color
* You can now set the language for the consent popups

### v1.0.1 - 10/07/2018
* Remove unnecessary logs
* Updated the README

### v1.0.0 - 10/07/2018
* Add consent flow + custom consent popups
* Consents are now send to Jack+Joe
* Location permission is updated if already set
* Improved logging
* Fetch + upload settings to Jack+Joe
* Send device language to the server

### v0.0.3 - 04/07/2018
* Allow external developers to configure the username+password

### v0.0.2 - 04/07/2018
* Bugfixes
* Added the cocoapod
* Fetch + parse consents from Jack+Joe

### v0.0.1 - 02/07/2018
* Bugfixes
* Tracking send to Jack+Joe
* Added the cocoapod
* Updated the accessibility for the files
* Initial commit
