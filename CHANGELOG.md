## Changelog

### v2.2.1 - stable release - 12/03/2024

- Changed the logic to determine the keywindow

### v2.2.0 - stable release - 23/02/2024

- Upload consent to server when `updateConsent` is called
- Interacts are send to the server with the correct format
- Added force tracking method
- Added method to fetch data the SDK version
- Precise location is send as a consent to the server

### v2.1.10 - stable release - 05/12/2023

- Added additional tracking stats and bug fixes (metadata, uppercaseID, permission sync)

### v2.1.9 - stable release - 05/12/2023

- Bugfixes for the interacts
  
### v2.1.8 - stable release - 05/12/2023

- Bugfixes for the interacts

### v2.1.7 - stable release - 21/09/2023

- Log more location permissions
  
### v2.1.6 - stable release - 21/09/2023

- Send precise location on/off to the backend
- Removed the callback from the stop tracking function
  
### v2.1.5 - stable release - 04/06/2023

- Fixed an issue where the ID is send over in lowercase

### v2.1.4 - stable release - 02/06/2023

- Allow the SDK to connect to the staging environment

### v2.1.3 - stable release - 01/06/2023

- Added the option to display debug logs
  
### v2.1.2 - stable release - 21/01/2022

- Improved the interacts

### v2.1.1 - stable release - 07/01/2022

- Improved the interacts

### v2.1.0 - stable release - 30/11/2021

- Improved the interacts
  
### v2.0.3 - stable release - 07/10/2021

- Fixed a crash caused by an infinity value
  
### v2.0.2 - stable release - 07/10/2021

- Minor improvements 

### v2.0.1 - stable release - 22/06/2021

- Minor improvements 

### v2.0.0 - stable release - 04/05/2021

- Added support for Swift Package Manager
- Moved to an XCFramework
- Support for `BUILD_LIBRARY_FOR_DISTRIBUTION`

### v1.9.2 - stable release - 04/05/2021

- Support for 5.4.0 Swift binary

### v1.9.1 - stable release - 24/09/2020

- Support for 5.3.1 Swift binary

### v1.9 - stable release - 24/09/2020

- added `getMeta`

### v1.8.0 - stable release - 25/08/2020

- Support for iOS 14
- Vendorid is used in iOS 14
- Added the `i386` and `X86_64` architectures again to the release framework

### v1.7.4 - stable release - 13/07/2020

- Removed the `i386` and `X86_64` architectures from the release framework

### v1.7.3 - stable release - 08/07/2020

- Initializer for `AccuratConfig` is now compatible with objective-c

### v1.7.2 - stable release - 06/07/2020

- Added an `updateConsentObjc` method

### v1.7.1 - stable release - 19/06/2020

- New xcode compatibility update
- Minor improvements

### v1.7.0 - stable release - 8/02/2020

- You can now configure which consents should be asked by the SDK

### v1.6.2 - stable release - 19/01/2020

- Bugfixes

### v1.6.1 - stable release - 16/01/2020

- Bugfixes

### v1.6.0 - stable release - 05/01/2020

- Objective-c support

### v1.5.1 - stable release - 26/11/2019

- Swift 5.1.2 support

### v1.5.0 - stable release - 22/09/2019

- iOS 13.0 support
- expose onLocationUpdate function

### v1.4.5 - stable release - 21/08/2019

- Hyperlinks match the brandcolor
- The interact is now batched

### v1.4.4 - stable release - 23/07/2019

- Bugfix callback for the startTracking

### v1.4.3 - stable release - 23/05/2019

- Added a callback to the startTracking
- Bugfixes

### v1.4.2 - stable release - 13/05/2019

- Bugfixes

### v1.4.1 - 16/04/2019

- Updated the README
- Bugfixes

### v1.4.0 - 21/03/2019

- Added the getSegments function
- Added extra data to a local notification
- Bugfixes

### v1.3.0 - stable release - 9/01/2019

- Split the location permission into two permissions (location tracking and always location tracking)

### v1.2.0 - stable release - 29/11/2018

- Added the interact function
- Crash fix when Adid was disabled
- Bugfixes

### v1.1.8 - 19/10/2018

- Bugfixes

### v1.1.7 - 19/10/2018

- Bugfixes

### v1.1.6 - 10/10/2018

- Bugfixes

### v1.1.5 - 3/09/2018

- Background fetch improvements

### v1.1.4 - 31/08/2018

- Bugfix visits timestamp

### v1.1.3 - 28/08/2018

- Bugfix GDPR flow

### v1.1.2 - 24/08/2018

- Improvements to the framework
- Bugfixes

### v1.1.1 - 16/08/2018

- Improvements to the framework
- Bugfixes

### v1.1.0 - stable release - 03/08/2018

- Bugfixes
- Improvements to the framework
- Added unlimited geofences
- Added local notification for geofence
- Fetch more locations
- Improvements for the popup view
- Improvements for the memory

### v1.0.6 - 19/07/2018

- Improvements to the framework

### v1.0.5 - 19/07/2018

- Bugfixes
- Improvements for the popup view

### v1.0.4 - 18/07/2018

- Bugfixes
- Improved logs

### v1.0.3 - 13/07/2018

- Bugfixes
- Updated the context of the locations

### v1.0.2 - 13/07/2018

- Bugfixes
- Updated the userconsent state so that it accepts integers as a state value
- Pass platform to the GET consent api call
- Use ios_transmission_interval instead of the transmission_interval of the GET settings
- Made the img tag clickable
- The refuse button has a less striking color
- You can now set the language for the consent popups

### v1.0.1 - 10/07/2018

- Remove unnecessary logs
- Updated the README

### v1.0.0 - 10/07/2018

- Add consent flow + custom consent popups
- Consents are now send to API
- Location permission is updated if already set
- Improved logging
- Fetch + upload settings to API
- Send device language to the server

### v0.0.3 - 04/07/2018

- Allow external developers to configure the username+password

### v0.0.2 - 04/07/2018

- Bugfixes
- Added the cocoapod
- Fetch + parse consents from API

### v0.0.1 - 02/07/2018

- Bugfixes
- Tracking send to API
- Added the cocoapod
- Updated the accessibility for the files
- Initial commit
