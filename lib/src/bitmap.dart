part of flutter_platform_maps;

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
      bitmap = googleMaps.BitmapDescriptor.fromAssetImage(
        configuration,
        assetName,
        bundle: bundle,
        package: package,
      );
    }
    return BitmapDescriptor._(bitmap);
  }
}
