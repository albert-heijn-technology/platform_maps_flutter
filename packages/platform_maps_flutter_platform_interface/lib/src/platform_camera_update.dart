import 'package:flutter/foundation.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class PlatformCameraUpdate extends PlatformInterface {
  /// Creates a new [PlatformCameraUpdate]
  factory PlatformCameraUpdate() {
    assert(
      PlatformMapsPlatform.instance != null,
      'A platform implementation for `platform_maps_flutter` has not been set. Please '
      'ensure that an implementation of `PlatformMapsPlatform` has been set to '
      '`PlatformMapsPlatform.instance` before use. For unit testing, '
      '`PlatformMapsPlatform.instance` can be set with your own test implementation.',
    );
    final PlatformCameraUpdate cameraUpdateDelegate =
        PlatformMapsPlatform.instance!.createPlatformCameraUpdate();
    PlatformInterface.verify(cameraUpdateDelegate, _token);
    return cameraUpdateDelegate;
  }

  @protected
  PlatformCameraUpdate.implementation() : super(token: _token);

  static final Object _token = Object();

  CameraUpdate newCameraPosition(CameraPosition cameraPosition);
  CameraUpdate newLatLng(LatLng latLng);
  CameraUpdate newLatLngZoom(LatLng latLng, double zoom);
  CameraUpdate newLatLngBounds(LatLngBounds bounds, double padding);
  CameraUpdate zoomBy(double amount);
  CameraUpdate zoomIn();
  CameraUpdate zoomOut();
  CameraUpdate zoomTo(double zoom);
}
