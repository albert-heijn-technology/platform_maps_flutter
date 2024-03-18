import 'dart:typed_data';

import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple_maps;
import 'package:platform_maps_flutter_apple/src/apple_maps_camera_update.dart';
import 'package:platform_maps_flutter_apple/src/mapper_extensions.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';

class AppleMapsPlatformController extends PlatformMapsPlatformController {
  AppleMapsPlatformController(this._appleMapController);
  final apple_maps.AppleMapController _appleMapController;

  @override
  Future<void> animateCamera(CameraUpdate cameraUpdate) {
    if (CameraUpdate case AppleMapsCameraUpdate cameraUpdate) {
      return _appleMapController.animateCamera(cameraUpdate.appleMapsCameraUpdate);
    }
    throw UnsupportedError(
      'AppleMapsPlatformController: animateCamera - cameraUpdate is not a AppleMapsCameraUpdate\n${cameraUpdate.toString()}',
    );
  }

  @override
  Future<LatLngBounds> getVisibleRegion() async {
    final visibleRegion = await _appleMapController.getVisibleRegion();
    return visibleRegion.platformLatLngBounds;
  }

  @override
  Future<void> hideMarkerInfoWindow(MarkerId markerId) {
    return _appleMapController.hideMarkerInfoWindow(markerId.appleMapsAnnotationId);
  }

  @override
  Future<bool> isMarkerInfoWindowShown(MarkerId markerId) async {
    return (await _appleMapController.isMarkerInfoWindowShown(markerId.appleMapsAnnotationId)) ??
        false;
  }

  @override
  Future<void> moveCamera(CameraUpdate cameraUpdate) {
    if (CameraUpdate case AppleMapsCameraUpdate cameraUpdate) {
      return _appleMapController.moveCamera(cameraUpdate.appleMapsCameraUpdate);
    }
    throw UnsupportedError(
      'AppleMapsPlatformController: moveCamera - cameraUpdate is not a AppleMapsCameraUpdate\n${cameraUpdate.toString()}',
    );
  }

  @override
  Future<void> showMarkerInfoWindow(MarkerId markerId) {
    return _appleMapController.showMarkerInfoWindow(markerId.appleMapsAnnotationId);
  }

  @override
  Future<Uint8List?> takeSnapshot() {
    return _appleMapController.takeSnapshot();
  }
}
