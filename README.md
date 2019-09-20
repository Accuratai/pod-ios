# Accurat SDK

This repository contains the cocoapod for the Accurat SDK. You can find the instruction to integrate the Accurat SDK into your iOS app below.

## Content

- Requirements
- Configure project
- Add SDK to project
- Integrate SDK into app
- Submit to App Store
- Contact

## Requirements

- iOS 8.0+
- Xcode 8.3+
- Swift 4+

## Configure project

In your project settings, go to _Capabilities > Background Modes_ and turn on _Background fetch_.

Then, add appropriate location usage descriptions to the `Info.plist` of your application. These strings will be displayed when prompting the user for location permissions.

For **Xcode 9**:

```xml
<key>NSLocationAlwaysUsageDescription</key>
<string>This makes it possible to send you notifications with relevant info, even when you are not using the app.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>That way, we can personalize the content and ads in the app based on your preferences.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This makes it possible to send you notifications with relevant info, even when you are not using the app.</string>
```

In order to support multiple languages, create a `InfoPlist.strings` file in the `<language>.lproj` directories for each language you want to support.

Example languages:

- `en.lproj`

```
NSLocationAlwaysUsageDescription = "This makes it possible to send you notifications with relevant info, even when you are not using the app.";
NSLocationWhenInUseUsageDescription = "That way, we can personalize the content and ads in the app based on your preferences.";
NSLocationAlwaysAndWhenInUseUsageDescription = "This makes it possible to send you notifications with relevant info, even when you are not using the app.";
```

- `nl.lproj`

```
NSLocationAlwaysUsageDescription = "Zo is het mogelijk om u notificaties te versturen met gepersonaliseerde inhoud, ook wanneer u de app niet gebruikt.";
NSLocationWhenInUseUsageDescription = "Zo kunnen we in de app de inhoud en advertenties personaliseren op maat van jouw voorkeuren.";
NSLocationAlwaysAndWhenInUseUsageDescription = "Zo is het mogelijk om u notificaties te versturen met gepersonaliseerde inhoud, ook wanneer u de app niet gebruikt.";
```

- `fr.lproj`

```
NSLocationAlwaysUsageDescription = "Il est donc possible de vous envoyer des notifications avec un contenu personnalisé, même lorsque vous n'utilisez pas l'application.";
NSLocationWhenInUseUsageDescription = "Comme ça, nous pouvons personnaliser le contenu et les publicités dans l'app en fonction de vos préférences.";
NSLocationAlwaysAndWhenInUseUsageDescription = "Il est donc possible de vous envoyer des notifications avec un contenu personnalisé, même lorsque vous n'utilisez pas l'application.";
```

Manually add these files to the project bundle. This can be achieved via right-clicking the project name in Xcode and choosing the Add files to X option, then selecting the files.

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

You can also pass a closure to receive an event when the SDK has finished the consent flow (the closure is optional):

```swift
Accurat.shared.startTracking(_ onComplete: (() -> Void)?)
```

It is recommended to implement this method in your `AppDelegate` after the `initialize`:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Accurat.shared.initialize(username: "ACCURAT_USERNAME", password: "ACCURAT_PASSWORD")
    Accurat.shared.startTracking() {
        //ask permission to send push notifications
    }
}
```

### Stop Tracking (optional)

To stop Accurat, call the stopTracking method:

```swift
Accurat.shared.stopTracking()
```

### Stop Tracking (optional)

Receive a callback when the SDK receives a new location. The array will at least contain one location that represents the current position.:

```swift
Accurat.shared.onLocationUpdate(callback: (([CLLocation]) -> Void)?)
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

### Interact (optional)

Add touchpoint interaction.

```swift
Accurat.shared.interact(_ group: String, campaign: String, touchpoint: String, onComplete: ((isSuccess) -> Void)?)
```

### Get segments (optional)

Fetch segments the current consumer belongs to. If the consumer does not exist, an empty list is returned.

```swift
Accurat.shared.getSegments(onComplete: @escaping (Array<String>) -> Void)
```

### GDPR (optional)

Before tracking the user's location, the user is asked to authorize location permissions for the app and give consent to use his location data.

If you want to start the consent flow separately from the tracking, call the askConsents method (also started by the tracking):

```swift
Accurat.shared.askConsents(onComplete: onComplete)
```

If you want to get the state of a consent, call the getConsentState method and provide a consent type:

```swift
Accurat.shared.getConsentState(.gdpr)
```

If you want to update the state of a consent, call the updateConsent method and provide a consent type + state:

```swift
Accurat.shared.updateConsent(.gdpr, state: 0/1)
```

### Notifications (optional)

If you want to receive the local notifications and the extra data you need to subscribe to it in your AppDelegate

```swift
func application(_ application: UIApplication, didReceive notification: UILocalNotification)
```

notification.userInfo will contain the extra data that is related to that notification

## Submit to App Store

Apple requires that you justify your use of background location. Add something materially similar to the following to the bottom of your App Store description: _This app uses background location to personalize the experience of its users. Continued use of background location may decrease battery life._

## Contact

Do you have any questions? E-mail us at steven@accurat.ai.
