import 'package:flutter/foundation.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class PlatformMapsPlatformController extends PlatformInterface {
  /// Creates a new [PlatformMapsPlatformController]
  factory PlatformMapsPlatformController() {
    assert(
      PlatformMapsPlatform.instance != null,
      'A platform implementation for `platform_maps_flutter` has not been set. Please '
      'ensure that an implementation of `PlatformMapsPlatform` has been set to '
      '`PlatformMapsPlatform.instance` before use. For unit testing, '
      '`PlatformMapsPlatform.instance` can be set with your own test implementation.',
    );
    final PlatformMapsPlatformController mapsControllerDelegate =
        PlatformMapsPlatform.instance!.createMapsController();
    PlatformInterface.verify(mapsControllerDelegate, _token);
    return mapsControllerDelegate;
  }

  /// Used by the platform implementation to create a new
  /// [PlatformBitmapDescriptor].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  PlatformMapsPlatformController.implementation() : super(token: _token);

  static final Object _token = Object();

  Future<void> showMarkerInfoWindow(MarkerId markerId);
  Future<void> hideMarkerInfoWindow(MarkerId markerId);
  Future<bool> isMarkerInfoWindowShown(MarkerId markerId);
  Future<void> animateCamera(CameraUpdate cameraUpdate);
  Future<void> moveCamera(CameraUpdate cameraUpdate);
  Future<LatLngBounds> getVisibleRegion();
  Future<Uint8List?> takeSnapshot();
}
