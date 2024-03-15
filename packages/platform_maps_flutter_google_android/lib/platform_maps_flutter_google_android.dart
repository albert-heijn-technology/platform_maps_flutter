library platform_maps_flutter_google;

import 'package:platform_maps_flutter_google_android/src/google_maps_bitmap_descriptor.dart';
import 'package:platform_maps_flutter_google_android/src/google_maps_camera_update.dart';
import 'package:platform_maps_flutter_google_android/src/google_maps_widget.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart'
    as google_maps;

class PlatformMapsPlugin extends PlatformMapsPlatform {
  static void registerWith() {
    PlatformMapsPlatform.instance = PlatformMapsPlugin();
  }

  /// Create a new [PlatformPlatformMapsWidget].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [PlatformMap] in `platform_maps_flutter` instead.
  @override
  PlatformMapsPlatformWidget createPlatformMapsPlatformWidget(
    PlatformMapsPlatformWidgetCreationParams params,
  ) {
    return GoogleMapsWidget(params);
  }

  /// Create a new [PlatformBitmapDescriptor].
  /// This function should only be called by the app-facing package.
  @override
  PlatformBitmapDescriptor<T> createBitmapDescriptor<T>() {
    if (T == google_maps.BitmapDescriptor) {
      return GoogleMapsBitmapDescriptor() as PlatformBitmapDescriptor<T>;
    }
    throw UnsupportedError('Unsupported type $T for BitmapDescriptor');
  }

  @override
  PlatformCameraUpdate createPlatformCameraUpdate() {
    return GoogleMapsPlatformCameraUpdate();
  }
}
