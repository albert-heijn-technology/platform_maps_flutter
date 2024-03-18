import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple_maps;

class AppleMapsBitmapDescriptor extends PlatformBitmapDescriptor<apple_maps.BitmapDescriptor> {
  AppleMapsBitmapDescriptor() : super.implementation();
  @override
  Future<apple_maps.BitmapDescriptor> fromAssetImage(
      ImageConfiguration configuration, String assetName,
      {AssetBundle? bundle, String? package}) {
    return apple_maps.BitmapDescriptor.fromAssetImage(
      configuration,
      assetName,
      bundle: bundle,
      package: package,
    );
  }

  @override
  apple_maps.BitmapDescriptor fromBytes(Uint8List byteData) {
    return apple_maps.BitmapDescriptor.fromBytes(byteData);
  }
}
