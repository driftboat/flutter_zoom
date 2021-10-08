# Flutter Zoom
A Flutter plugin for the Zoom Client SDK.

## Zoom SDK Versions

Android: zoom-sdk-android-5.7.1.1268
 
iOS: zoom-sdk-ios-5.7.1.645

## Installation from pub.dev
https://pub.dev/packages/zoom

After install the library, must run the follow script to get some sdk stuff for the first time:
```shell script
flutter pub run zoom:unzip_zoom_sdk
```
## Installation from github

```yaml
  zoom:
    git:
      url: git@github.com:driftboat/flutter_zoom.git
      ref: main
      path: zoom
```
After install the library, must run the follow script to get some sdk stuff for the first time:
```shell script
flutter pub run zoom:unzip_zoom_sdk
```

### iOS

Add two rows to the `ios/Runner/Info.plist`:

- one with the key `Privacy - Camera Usage Description` and a usage description.
- and one with the key `Privacy - Microphone Usage Description` and a usage description.

Or in text format add the key:

```xml
<key>NSCameraUsageDescription</key>
<string>Need to use the camera for call</string>
<key>NSMicrophoneUsageDescription</key>
<string>Need to use the microphone for call</string>
```


Diable BITCODE in the `ios/Podfile`:

```
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end
```

**NOTE for testing on the iOS simulator**

If you want to use the iOS Simulator to test your app, you will need to ensure you have the iOS Dev Zoom SDK as a dependency. 

To use the Dev Zoom SDK, run the following
```shell script
flutter pub run zoom:unzip_zoom_sdk dev
```
    
To switch back to the normal Zoom SDK, simply run

```shell script
flutter pub run zoom:unzip_zoom_sdk
```

### Android

Change the minimum Android sdk version to at the minimum 21 in your `android/app/build.gradle` file.

```
minSdkVersion 21
```

Disable shrinkResources for release buid
```
   buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.debug
            shrinkResources false 
            minifyEnabled false
        }
    }
```

### Web

Add stylesheet to the head of index.html
```html
<link type="text/css" rel="stylesheet" href="https://source.zoom.us/1.9.9/css/bootstrap.css" />
<link type="text/css" rel="stylesheet" href="https://source.zoom.us/1.9.9/css/react-select.css" />
```
Import ZoomMtg dependencies to the body of index.html
```html
<!-- import ZoomMtg dependencies -->
   <script src="https://source.zoom.us/1.9.9/lib/vendor/react.min.js"></script>
   <script src="https://source.zoom.us/1.9.9/lib/vendor/react-dom.min.js"></script>
   <script src="https://source.zoom.us/1.9.9/lib/vendor/redux.min.js"></script>
   <script src="https://source.zoom.us/1.9.9/lib/vendor/redux-thunk.min.js"></script>
   <script src="https://source.zoom.us/1.9.9/lib/vendor/lodash.min.js"></script>
   <script src="https://source.zoom.us/1.9.9/lib/av/1502_js_media.min.js"></script>

   <!-- import ZoomMtg -->
   <script src="https://source.zoom.us/zoom-meeting-1.9.9.min.js"></script>

   <script src="main.dart.js" type="application/javascript"></script>
```
Append "zmmtg-root" after zoom inited 
```dart
if (kIsWeb) {
    var zr = window.document.getElementById("zmmtg-root");
    querySelector('body').append(zr);
}
```

## example
- Auth zoom with "SDK App JWT Token"
  - Create SDK App JWT Token
    - Create SDK Key&Secret https://marketplace.zoom.us/docs/sdk/native-sdks/auth#key-secret-2
    - Generate JWT Token from https://jwt.io/ for testing. （Get it from your server for distribution，You can get current timestamp from https://www.unixtimestamp.com/. ）   
      Replace "PAYLOAD" as bellow, Enter your "SDK Secret" in "your-256-bit-secret",Get  "your jwtToken" from the left. 
      
      ```
      {
        "appKey": "string", // Your SDK key
        "iat": long, // access token issue timestamp
        "exp": long, // access token expire timestamp (The exp should be later than or equal to tokenExp)
        "tokenExp": long // should be a timestamp that is at least 30 minutes later than the iat)
      }
      ```
      PAYLOAD Example：  
      ```
      {
        "appKey": "xxxxxxxxxxxxxxxxxxxx", 
        "iat": 1615510799, 
        "exp": 1647017999, 
        "tokenExp": 1647017999 
      }
      ```
  -  replace "your jwtToken" in "zoom/example/lib/join_screen.dart"
  
- If you don't want use jwtToken, You can Auth zoom with "SDK App Key&Secret"
  - Comment out "your jwtToken" and Uncomment "appKey&appSecret", it should be like this:  
  ```
  ZoomOptions zoomOptions = new ZoomOptions(
      domain: "zoom.us",
      //https://marketplace.zoom.us/docs/sdk/native-sdks/auth
      //https://jwt.io/
      //--todo from server
      //jwtToken: "your jwtToken",
      appKey: "appKey", // Replace with with key got from the Zoom Marketplace ZOOM SDK Section
      appSecret: "appSecret", // Replace with with secret got from the Zoom Marketplace ZOOM SDK Section
    );
  ```
      



# reference
https://github.com/decodedhealth/flutter_zoom_plugin
