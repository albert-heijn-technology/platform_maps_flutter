library platform_maps_flutter_apple;

import 'package:platform_maps_flutter_apple/src/apple_maps_bitmap_descriptor.dart';
import 'package:platform_maps_flutter_apple/src/apple_maps_camera_update.dart';
import 'package:platform_maps_flutter_apple/src/apple_maps_widget.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';

class PlatformMapsApple extends PlatformMapsPlatform {
  static void registerWith() {
    PlatformMapsPlatform.instance = PlatformMapsApple();
  }

  /// Create a new [PlatformPlatformMapsWidget].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [PlatformMap] in `platform_maps_flutter` instead.
  @override
  PlatformMapsPlatformWidget createPlatformMapsPlatformWidget(
    PlatformMapsPlatformWidgetCreationParams params,
  ) {
    return AppleMapsWidget(params);
  }

  /// Create a new [PlatformBitmapDescriptor].
  /// This function should only be called by the app-facing package.
  @override
  PlatformBitmapDescriptor createBitmapDescriptor() {
    return AppleMapsPlatformBitmapDescriptor();
  }

  @override
  PlatformCameraUpdate createPlatformCameraUpdate() {
    return AppleMapsPlatformCameraUpdate();
  }
}
