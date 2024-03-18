import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple_maps;
import 'package:platform_maps_flutter_apple/src/mapper_extensions.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';

class AppleMapsPlatformCameraUpdate extends PlatformCameraUpdate {
  AppleMapsPlatformCameraUpdate() : super.implementation();

  @override
  CameraUpdate newCameraPosition(CameraPosition cameraPosition) {
    return AppleMapsCameraUpdate._(
      apple_maps.CameraUpdate.newCameraPosition(
        cameraPosition.appleMapsCameraPosition,
      ),
    );
  }

  @override
  CameraUpdate newLatLng(LatLng latLng) {
    return AppleMapsCameraUpdate._(
      apple_maps.CameraUpdate.newLatLng(
        latLng.appleMapsLatLng,
      ),
    );
  }

  @override
  CameraUpdate newLatLngBounds(LatLngBounds bounds, double padding) {
    return AppleMapsCameraUpdate._(
      apple_maps.CameraUpdate.newLatLngBounds(
        bounds.appleMapsLatLngBounds,
        padding,
      ),
    );
  }

  @override
  CameraUpdate newLatLngZoom(LatLng latLng, double zoom) {
    return AppleMapsCameraUpdate._(
      apple_maps.CameraUpdate.newLatLngZoom(
        latLng.appleMapsLatLng,
        zoom,
      ),
    );
  }

  @override
  CameraUpdate zoomBy(double amount) {
    return AppleMapsCameraUpdate._(
      apple_maps.CameraUpdate.zoomBy(amount),
    );
  }

  @override
  CameraUpdate zoomIn() {
    return AppleMapsCameraUpdate._(
      apple_maps.CameraUpdate.zoomIn(),
    );
  }

  @override
  CameraUpdate zoomOut() {
    return AppleMapsCameraUpdate._(
      apple_maps.CameraUpdate.zoomOut(),
    );
  }

  @override
  CameraUpdate zoomTo(double zoom) {
    return AppleMapsCameraUpdate._(
      apple_maps.CameraUpdate.zoomTo(zoom),
    );
  }
}

class AppleMapsCameraUpdate extends CameraUpdate {
  const AppleMapsCameraUpdate._(this.appleMapsCameraUpdate);
  final apple_maps.CameraUpdate appleMapsCameraUpdate;
}
