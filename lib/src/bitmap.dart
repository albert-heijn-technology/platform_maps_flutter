part of platform_maps_flutter;

/// Defines a bitmap image. For a marker, this class can be used to set the
/// image of the marker icon. For a ground overlay, it can be used to set the
/// image to place on the surface of the earth.

class BitmapDescriptor {
  final dynamic bitmapDescriptor;

  BitmapDescriptor._(this.bitmapDescriptor);

  /// Creates a BitmapDescriptor that refers to the default marker image.
  static BitmapDescriptor get defaultMarker {
    if (Platform.isIOS) {
      return BitmapDescriptor._(appleMaps.BitmapDescriptor.defaultAnnotation);
    } else if (Platform.isAndroid) {
      return BitmapDescriptor._(googleMaps.BitmapDescriptor.defaultMarker);
    }
    return null;
  }

  /// Creates a [BitmapDescriptor] from an asset image.
  /// Asset images in flutter are stored per: https://flutter.dev/docs/development/ui/assets-and-images#declaring-resolution-aware-image-assets
  ///
  /// This method takes into consideration various asset resolutions and scales the images to the right resolution depending on the dpi.
  ///
  /// Don't forget to rebuild the map with the new Icons if it was already build.
  static Future<BitmapDescriptor> fromAssetImage(
    ImageConfiguration configuration,
    String assetName, {
    AssetBundle bundle,
    String package,
  }) async {
    dynamic bitmap;
    if (Platform.isIOS) {
      bitmap = await appleMaps.BitmapDescriptor.fromAssetImage(
        configuration,
        assetName,
        bundle: bundle,
        package: package,
      );
    } else if (Platform.isAndroid) {
      bitmap = await googleMaps.BitmapDescriptor.fromAssetImage(
        configuration,
        assetName,
        bundle: bundle,
        package: package,
      );
    }
    return BitmapDescriptor._(bitmap);
  }

  /// Creates a BitmapDescriptor using an array of bytes that must be encoded
  /// as PNG.
  static BitmapDescriptor fromBytes(Uint8List byteData) {
    var bitmap = Platform.isAndroid
        ? googleMaps.BitmapDescriptor.fromBytes(byteData)
        : appleMaps.BitmapDescriptor.fromBytes(byteData);
    return BitmapDescriptor._(bitmap);
  }
}
