import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:platform_maps_flutter_apple/platform_maps_flutter_apple.dart';
import 'package:platform_maps_flutter_apple/src/apple_maps_bitmap_descriptor.dart';
import 'package:platform_maps_flutter_apple/src/apple_maps_camera_update.dart';
import 'package:platform_maps_flutter_apple/src/apple_maps_widget.dart';

import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';

void main() {
  test('Verify widget generation', () {
    PlatformMapsApple.registerWith();

    final widget = PlatformMapsPlatformWidget(
      const PlatformMapsPlatformWidgetCreationParams(
        initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
      ),
    );
    expect(widget, isA<AppleMapsWidget>());
  });

  test('Verify bitmap descriptor generation', () {
    PlatformMapsApple.registerWith();

    final platformBitmapDescriptor = PlatformBitmapDescriptor();
    expect(platformBitmapDescriptor, isA<AppleMapsPlatformBitmapDescriptor>());

    final bitmapDescriptor = platformBitmapDescriptor.fromBytes(Uint8List(0));
    expect(bitmapDescriptor, isA<AppleMapsBitmapDescriptor>());
  });

  test('Verify camera update generation', () {
    PlatformMapsApple.registerWith();

    final platformCameraUpdate = PlatformCameraUpdate();
    expect(platformCameraUpdate, isA<AppleMapsPlatformCameraUpdate>());

    final cameraUpdate = platformCameraUpdate.zoomIn();
    expect(cameraUpdate, isA<AppleMapsCameraUpdate>());
  });
}
