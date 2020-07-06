# Accurat iOS SDK

You can find the instruction to integrate the Accurat SDK into your iOS app below.

## Content

- Requirements
- Compatibility
- Configure project
- Add SDK to project
- Integrate SDK into app
- Submit to App Store
- Contact

## Requirements

- iOS 9.0+
- Xcode 8.3+

## Compatibility

- Swift 4+
- Objective-c

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
let config = AccuratConfig(username: "ACCURAT_USERNAME", password: "ACCURAT_PASSWORD", features: [.gdpr, .location])
Accurat.shared.initialize(config: config)
```

where `ACCURAT_USERNAME` and `ACCURAT_PASSWORD` are strings containing your Accurat username and password. `features` is an optional parameter which indicates the consents which are asked by the SDK (see Consent Flow section).

Additionally, implement the following method in your `AppDelegate`:

```swift
func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
     Accurat.shared.performBackgroundFetchWithCompletionHandler(completionHandler)
}
```

### Start Tracking (required)

Call the startTracking method to start tracking. If configured, this will also trigger the consent flow (see Consent Flow section).

```swift
Accurat.shared.startTracking()
```

You can also pass a closure to receive an event when the SDK has finished the consent flow (the closure is optional):

```swift
Accurat.shared.startTracking(_ onComplete: (() -> Void)?)
```

_The `startTracking`-method has to be called on each app start._

It is recommended to implement this method in your `AppDelegate` after the `initialize`.

### Consent flow (required)

Before the SDK starts tracking the users' coordinates, two consents have to be given by the user:

1. The GDPR consent, which is a legal consent that is required to process personal data.
2. The location consent, which is a technical consent that is required to be able to collect location data of the user.

Asking the consents can be implemented by the SDK (recommended) or by the app developer himself.

##### Implemented by SDK

When `.gdpr` and `.location` features are given during the initialization, a flow which ask these consents is automatically started when the `startTracking`-method is called. The consent flow is visualized in this image:
![consentflow](https://accurat.ai/assets/consentflow-ios.png "Consent Flow")

First, the user is asked for the GDPR consent through a pop-up screen. Second, if the user agrees to the GDPR consent, pop-up dialogs are shown to ask his permissions to retrieve his locations. If the user gives GDPR consent and location permissions, the tracking is started.

There is some functionality added to increase the conversion rate (users giving their gdpr and location consent):

- If the user does not give his consent, the user is asked for the consent again with a delay of at least 48 hours. The consent is asked 3 times at most.
- Before showing the iOS pop-up which asks the in-app location permission (screen 2b), we explain why the user should give his permission (screen 2a).
- It is explained to the user that iOS will request his always location permission (screen 2d), with an explanation why the user should give this permission (screen 2c)

The texts shown in the popup-screens and the number of delays (default 3) can be changed through our backend.

This entire flow can be implemented by adding this code in your `AppDelegate`:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let config = AccuratConfig(username: "ACCURAT_USERNAME", password: "ACCURAT_PASSWORD", features: [.gdpr, .location])
    Accurat.shared.initialize(config: config)
    // start tracking (which will also starts the consent flow)
    Accurat.shared.startTracking() {
        //consent flow is finished, eg. ask permission to send push notifications
    }
}
```

##### Implemented by App Developer

The consents can also be asked by the app developer in the existing flow of the app. Note that the tracking will only work if the SDK receives an approved gdpr and location consent.

The GDPR consent state can be updated by calling the `updateConsent()`-method and provide a consent type and consent state:

```swift
Accurat.shared.updateConsent(.gdpr, state: 0/1)
```

If you want to get the state of the GDPR consent, call the `getConsentState()`-method:

```swift
Accurat.shared.getConsentState(.gdpr)
```

The location permission has not to be passed to the SDK, as the SDK retrieves the location permission of the user through the app settings on the device.

Finally call `startTracking()` to start the tracking. Note that `startTracking()` has to be called on each app start, even when no consent states are changed.

This entire flow can be implemented by adding this code in your `AppDelegate`:

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let config = AccuratConfig(username: "ACCURAT_USERNAME", password: "ACCURAT_PASSWORD", features: [])
    Accurat.shared.initialize(config: config)
    if (userOpensTheAppForTheFirstTime()) {
        // Own GDPR consent handling
        let gdprState = askOwnGdprConsent();
        Accurat.shared.updateConsent(.gdpr, gdprState)

        // Own location permission handling
        askOwnLocationPermission();
    }
    // start tracking
    Accurat.shared.startTracking()
}
```

The consent flow can also partially be implemented by the SDK and partially by the app developer. For instance, by only passing `.location` in the config, the GDPR consent has to be handled by the app developer, but the location permissions will be handled by the SDK.

### Stop Tracking (optional)

To stop the location tracking, call the `stopTracking`-method:

```swift
Accurat.shared.stopTracking()
```

### Is tracking enabled? (optional)

If you want to know if the tracking is enabled or not, call the `isTrackingEnabled` variable:

```swift
Accurat.shared.isTrackingEnabled
```

### Receive location updates (optional)

Receive a callback when the SDK receives a new location. The array will at least contain one location that represents the current position:

```swift
Accurat.shared.onLocationUpdate(callback: ([CLLocation]) -> Void)
```

### Notifications (optional)

If you want to receive the local notifications and the extra data you need to subscribe to it in your `AppDelegate`

```swift
func application(_ application: UIApplication, didReceive notification: UILocalNotification)
```

`notification.userInfo` will contain the extra data that is related to that notification.

### Set language (optional)

If you want to change the language of the user, you can update the language. This language will i.e. be used in the consent popups and geofence notifications. When no language is, the device language is used, or English if the device language is not supported.

```swift
Accurat.shared.setLanguage(.en/.nl/.fr)
```

### Interact (optional)

Add interaction for consumer, based on given brand, campaign and touchpoint. If campaign and/or touchpoint does not exist, they will be created.

```swift
Accurat.shared.interact(_ brand: String, campaign: String, touchpoint: String, onComplete: ((isSuccess) -> Void)?)
```

### Get segments (optional)

Fetch segments the current consumer belongs to. If the consumer does not exist, an empty list is returned.

```swift
Accurat.shared.getSegments(onComplete: @escaping (Array<String>) -> Void)
```

### Invoke right (optional)

Fetch segments the current consumer belongs to. If the consumer does not exist, an empty list is returned.

```swift
Accurat.shared.func invokeRight(right: String, info: String?, completion: ((Result<Void, Error>) -> Void)?)
```

## Submit to App Store

Apple requires that you justify your use of background location. Add something materially similar to the following to the bottom of your App Store description: _This app uses background location to personalize the experience of its users. Continued use of background location may decrease battery life._

## Contact

Do you have any questions? E-mail us at steven@accurat.ai.
