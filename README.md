# Accurat SDK #

This repository contains the cocoapod for the Accurat SDK. You can find the instruction to integrate the Accurat SDK into your iOS app below.

## Content ##
* Requirements
* Configure project
* Add SDK to project
* Integrate SDK into app
* Submit to App Store
* Changelog

## Requirements

- iOS 8.0+
- Xcode 8.3+
- Swift 4+

## Configure project

Add appropriate location usage descriptions to the `Info.plist` of your application. These strings will be displayed when prompting the user for background location permissions.

For **Xcode 9**:
```xml
<key>NSLocationAlwaysUsageDescription</key>
<string>Allow location access to personalize your experience.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>Allow location access to personalize your experience.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Allow location access to personalize your experience.</string>
```

Then, in your project settings, go to *Capabilities > Background Modes* and turn on *Background fetch*.

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

### Import the SDK (required)

```swift
import Accurat
```

### Initialize SDK (required)
Initialize the SDK in your `AppDelegate` class before calling any other Accurat methods.

In `application(_:didFinishLaunchingWithOptions:)`, call:
```swift
Accurat.shared.initialize(username: "ACCURAT_USERNAME", password: "ACCURAT_PASSWORD")
```
where `ACCURAT_USERNAME` and `ACCURAT_PASSWORD` are strings containing your Accurat username and password.

Additionally, implement the following method in your `AppDelegate`:
```swift
func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
     Accurat.shared.performBackgroundFetchWithCompletionHandler(completionHandler)
}
```

### Start Tracking (required)
To start Accurat, call the startTracking method (also starts the consent flow, see GDPR):
```swift
Accurat.shared.startTracking()
```
It is recommended to implement this method in your `AppDelegate`:
```swift
func applicationWillEnterForeground(_ application: UIApplication) {
     Accurat.shared.startTracking()
}
```

### Stop Tracking (optional)
To stop Accurat, call the stopTracking method:
```swift
Accurat.shared.stopTracking()
```

### Is tracking enabled? (optional)
If you want to know if the tracking is enabled or not, call the isTrackingEnabled variable:
```swift
Accurat.shared.isTrackingEnabled
```

### Set language (optional)
If you want to change the language of the user, you can update the language. This language will i.e. be used in the consent popups. When no language is, the device language is used.
```swift
Accurat.shared.setLanguage(.en/.nl/.fr)
```

### GDPR (optional)

Before tracking the user's location, the user is asked to authorize location permissions for the app and give consent to use his location data.

If you want to start the consent flow separately from the tracking, call the askConsents method (also started by the tracking):
```swift
Accurat.shared.askConsents(onComplete: onComplete)
```

If you want to get the state of a consent, call the getConsentState method and provide a consent type:
```swift
Accurat.shared.getConsentState(.tracking)
```

If you want to update the state of a consent, call the updateConsent method and provide a consent type + state:
```swift
Accurat.shared.updateConsent(.tracking, state: 0/1)
```

## Submit to App Store

Apple requires that you justify your use of background location. Add something materially similar to the following to the bottom of your App Store description: *This app uses background location to personalize the experience of its users. Continued use of background location may decrease battery life.*

--

Do you have any questions? E-mail us at steven@accurat.ai.

## Changelog

### v1.0.6 - stable release - 19/07/2018
* Improvements to the framework

### v1.0.5 - 19/07/2018
* Bugfixes
* Improvements for popup view

### v1.0.4 - 18/07/2018
* Bugfixes
* Improved logs

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
