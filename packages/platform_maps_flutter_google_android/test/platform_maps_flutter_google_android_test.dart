import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:platform_maps_flutter_google_android/platform_maps_flutter_google_android.dart';
import 'package:platform_maps_flutter_google_android/src/google_maps_bitmap_descriptor.dart';
import 'package:platform_maps_flutter_google_android/src/google_maps_camera_update.dart';
import 'package:platform_maps_flutter_google_android/src/google_maps_widget.dart';

import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';

void main() {
  test('Verify widget generation', () {
    PlatformMapsGoogleAndroid.registerWith();

    final widget = PlatformMapsPlatformWidget(
      const PlatformMapsPlatformWidgetCreationParams(
        initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
      ),
    );
    expect(widget, isA<GoogleMapsWidget>());
  });

  test('Verify bitmap descriptor generation', () {
    PlatformMapsGoogleAndroid.registerWith();

    final platformBitmapDescriptor = PlatformBitmapDescriptor();
    expect(platformBitmapDescriptor, isA<GoogleMapsPlatformBitmapDescriptor>());

    final bitmapDescriptor = platformBitmapDescriptor.fromBytes(Uint8List(0));
    expect(bitmapDescriptor, isA<GoogleMapsBitmapDescriptor>());
  });

  test('Verify camera update generation', () {
    PlatformMapsGoogleAndroid.registerWith();

    final platformCameraUpdate = PlatformCameraUpdate();
    expect(platformCameraUpdate, isA<GoogleMapsPlatformCameraUpdate>());

    final cameraUpdate = platformCameraUpdate.zoomIn();
    expect(cameraUpdate, isA<GoogleMapsCameraUpdate>());
  });
}
