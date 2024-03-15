import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart'
    as google_maps;

class GoogleMapsBitmapDescriptor extends PlatformBitmapDescriptor<google_maps.BitmapDescriptor> {
  GoogleMapsBitmapDescriptor() : super.implementation();
  @override
  Future<google_maps.BitmapDescriptor> fromAssetImage(
      ImageConfiguration configuration, String assetName,
      {AssetBundle? bundle, String? package}) {
    return google_maps.BitmapDescriptor.fromAssetImage(
      configuration,
      assetName,
      bundle: bundle,
      package: package,
    );
  }

  @override
  google_maps.BitmapDescriptor fromBytes(Uint8List byteData) {
    return google_maps.BitmapDescriptor.fromBytes(byteData);
  }
}
