import 'dart:typed_data';

import 'package:platform_maps_flutter_google_android/src/google_map_original.dart'
    as google_map_original;
import 'package:platform_maps_flutter_google_android/src/google_maps_camera_update.dart';
import 'package:platform_maps_flutter_google_android/src/mapper_extensions.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';

class GoogleMapsPlatformController extends PlatformMapsPlatformController {
  GoogleMapsPlatformController(this._googleMapController);
  final google_map_original.GoogleMapController _googleMapController;

  @override
  Future<void> animateCamera(CameraUpdate cameraUpdate) {
    if (cameraUpdate is GoogleMapsCameraUpdate) {
      return _googleMapController
          .animateCamera(cameraUpdate.googleMapsCameraUpdate);
    }
    throw UnsupportedError(
      'GoogleMapsPlatformController: animateCamera - cameraUpdate is not a GoogleMapsCameraUpdate\n${cameraUpdate.toString()}',
    );
  }

  @override
  Future<LatLngBounds> getVisibleRegion() async {
    final visibleRegion = await _googleMapController.getVisibleRegion();
    return visibleRegion.platformLatLngBounds;
  }

  @override
  Future<void> hideMarkerInfoWindow(MarkerId markerId) {
    return _googleMapController
        .hideMarkerInfoWindow(markerId.googleMapsMarkerId);
  }

  @override
  Future<bool> isMarkerInfoWindowShown(MarkerId markerId) {
    return _googleMapController
        .isMarkerInfoWindowShown(markerId.googleMapsMarkerId);
  }

  @override
  Future<void> moveCamera(CameraUpdate cameraUpdate) {
    if (cameraUpdate is GoogleMapsCameraUpdate) {
      return _googleMapController
          .moveCamera(cameraUpdate.googleMapsCameraUpdate);
    }
    throw UnsupportedError(
      'GoogleMapsPlatformController: moveCamera - cameraUpdate is not a GoogleMapsCameraUpdate\n${cameraUpdate.toString()}',
    );
  }

  @override
  Future<void> showMarkerInfoWindow(MarkerId markerId) {
    return _googleMapController
        .showMarkerInfoWindow(markerId.googleMapsMarkerId);
  }

  @override
  Future<Uint8List?> takeSnapshot() {
    return _googleMapController.takeSnapshot();
  }
}
