import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class PlatformBitmapDescriptor extends PlatformInterface {
  /// Creates a new [PlatformBitmapDescriptor]
  factory PlatformBitmapDescriptor() {
    assert(
      PlatformMapsPlatform.instance != null,
      'A platform implementation for `platform_maps_flutter` has not been set. Please '
      'ensure that an implementation of `PlatformMapsPlatform` has been set to '
      '`PlatformMapsPlatform.instance` before use. For unit testing, '
      '`PlatformMapsPlatform.instance` can be set with your own test implementation.',
    );
    final PlatformBitmapDescriptor bitmapDescriptorDelegate =
        PlatformMapsPlatform.instance!.createBitmapDescriptor();
    PlatformInterface.verify(bitmapDescriptorDelegate, _token);
    return bitmapDescriptorDelegate;
  }

  /// Used by the platform implementation to create a new
  /// [PlatformBitmapDescriptor].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  PlatformBitmapDescriptor.implementation() : super(token: _token);

  static final Object _token = Object();

  Future<BitmapDescriptor> fromAssetImage(
    ImageConfiguration configuration,
    String assetName, {
    AssetBundle? bundle,
    String? package,
  });

  BitmapDescriptor fromBytes(Uint8List byteData);
}
