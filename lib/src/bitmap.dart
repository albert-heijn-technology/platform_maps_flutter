part of flutter_platform_maps;

/// Defines a bitmap image. For a marker, this class can be used to set the
/// image of the marker icon. For a ground overlay, it can be used to set the
/// image to place on the surface of the earth.

class BitmapDescriptor {
  /// Creates a BitmapDescriptor that refers to the default marker image.
  static dynamic get defaultMarker {
    if (Platform.isIOS) {
      return appleMaps.BitmapDescriptor.defaultAnnotation;
    } else if (Platform.isAndroid) {
      return googleMaps.BitmapDescriptor.defaultMarker;
    }
    return null;
  }

  static dynamic fromAssetImage(
    ImageConfiguration configuration,
    String assetName, {
    AssetBundle bundle,
    String package,
  }) {
    if (Platform.isIOS) {
      return appleMaps.BitmapDescriptor.fromAssetImage(
        configuration,
        assetName,
        bundle: bundle,
        package: package,
      );
    } else if (Platform.isAndroid) {
      return googleMaps.BitmapDescriptor.fromAssetImage(
        configuration,
        assetName,
        bundle: bundle,
        package: package,
      );
    }
  }
}
