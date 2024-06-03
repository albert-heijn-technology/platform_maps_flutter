import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:platform_maps_flutter_platform_interface/src/platform_bitmap_descriptor.dart';

/// Defines a bitmap image. For a marker, this class can be used to set the
/// image of the marker icon. For a ground overlay, it can be used to set the
/// image to place on the surface of the earth.

abstract class BitmapDescriptor {
  /// Creates a [BitmapDescriptor] from an asset image.
  /// Asset images in flutter are stored per: https://flutter.dev/docs/development/ui/assets-and-images#declaring-resolution-aware-image-assets
  ///
  /// This method takes into consideration various asset resolutions and scales the images to the right resolution depending on the dpi.
  ///
  /// Don't forget to rebuild the map with the new Icons if it was already build.
  static Future<BitmapDescriptor> fromAssetImage(
    ImageConfiguration configuration,
    String assetName, {
    AssetBundle? bundle,
    String? package,
  }) async {
    return PlatformBitmapDescriptor().fromAssetImage(
      configuration,
      assetName,
      bundle: bundle,
      package: package,
    );
  }

  /// Creates a BitmapDescriptor using an array of bytes that must be encoded
  /// as PNG.
  static BitmapDescriptor fromBytes(Uint8List byteData) {
    return PlatformBitmapDescriptor().fromBytes(byteData);
  }
}
