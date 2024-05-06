import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple_maps;

class AppleMapsPlatformBitmapDescriptor extends PlatformBitmapDescriptor {
  AppleMapsPlatformBitmapDescriptor() : super.implementation();
  @override
  Future<AppleMapsBitmapDescriptor> fromAssetImage(
    ImageConfiguration configuration,
    String assetName, {
    AssetBundle? bundle,
    String? package,
  }) async {
    final descriptor = await apple_maps.BitmapDescriptor.fromAssetImage(
      configuration,
      assetName,
      bundle: bundle,
      package: package,
    );
    return AppleMapsBitmapDescriptor(descriptor);
  }

  @override
  AppleMapsBitmapDescriptor fromBytes(Uint8List byteData) {
    return AppleMapsBitmapDescriptor(
      apple_maps.BitmapDescriptor.fromBytes(byteData),
    );
  }
}

class AppleMapsBitmapDescriptor extends BitmapDescriptor {
  AppleMapsBitmapDescriptor(this.descriptor);
  apple_maps.BitmapDescriptor descriptor;
}
