import 'package:flutter/foundation.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class PlatformMapsPlatformController {
  Future<void> showMarkerInfoWindow(MarkerId markerId);
  Future<void> hideMarkerInfoWindow(MarkerId markerId);
  Future<bool> isMarkerInfoWindowShown(MarkerId markerId);
  Future<void> animateCamera(CameraUpdate cameraUpdate);
  Future<void> moveCamera(CameraUpdate cameraUpdate);
  Future<LatLngBounds> getVisibleRegion();
  Future<Uint8List?> takeSnapshot();
}
