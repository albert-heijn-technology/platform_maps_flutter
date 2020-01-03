# platform_maps_flutter

A Flutter package that provides a native map to both Android and iOS devices.

The plugin relies on Flutter's mechanism for embedding Android and iOS views. As that mechanism is currently in a developers preview, this plugin should also be considered a developers preview.

This package combines the [google_maps_flutter]("https://pub.dev/packages/google_maps_flutter") plugin with [apple_maps_flutter]("https://pub.dev/packages/apple_maps_flutter") to create a cross platform implementation of native maps for Android/iOS.

# Screenshots

|                                                    Android                                                     |                                                    iOS                                                     |
| :------------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------: |
| ![Example 1](https://github.com/LuisThein/flutter_platform_maps/blob/master/resources/android_screenshot1.png) | ![Example 2](https://github.com/LuisThein/flutter_platform_maps/blob/master/resources/ios_screenshot1.png) |
| ![Example 1](https://github.com/LuisThein/flutter_platform_maps/blob/master/resources/android_screenshot2.png) | ![Example 2](https://github.com/LuisThein/flutter_platform_maps/blob/master/resources/ios_screenshot2.png) |

# Current functionality

- Camera movement including bearing, heading, tilt (also animated)
- Markers, including custom marker images and Info windows
- Different map types
- Map manipulation, enable/disable gestures, show current location, show compass ...


# iOS

To use this plugin on iOS you need to opt-in for the embedded views preview by adding a boolean property to the app's Info.plist file, with the key `io.flutter.embedded_views_preview` and the value `YES`. You will also have to add the key `Privacy - Location When In Use Usage Description` with the value of your usage description.

# Android

Specify your API key in the application manifest android/app/src/main/AndroidManifest.xml:

```xml 
<manifest ...
  <application ...
    <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR KEY HERE"/>
```

## Sample Usage

```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlatformMap(
        initialCameraPosition: CameraPosition(
          target: const LatLng(47.6, 8.8796),
          zoom: 16.0,
        ),
        markers: Set<Marker>.of(
          [
            Marker(
              markerId: MarkerId('marker_1'),
              position: LatLng(47.6, 8.8796),
              consumeTapEvents: true,
              infoWindow: InfoWindow(
                title: 'PlatformMarker',
                snippet: "Hi I'm a Platform Marker",
              ),
              onTap: () {
                print("Marker tapped");
              },
            ),
          ],
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onTap: (location) => print('onTap: $location'),
        onCameraMove: (cameraUpdate) => print('onCameraMove: $cameraUpdate'),
        compassEnabled: true,
        onMapCreated: (controller) {
          Future.delayed(Duration(seconds: 2)).then(
            (_) {
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  const CameraPosition(
                    bearing: 270.0,
                    target: LatLng(51.5160895, -0.1294527),
                    tilt: 30.0,
                    zoom: 18,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
```

Suggestions and PR's to make this plugin better are always welcome. Please notice that the features provided by this package depend on the apple_maps_flutter plugin, which will improve in the future.


