import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';
import 'package:platform_maps_flutter_google/src/mapper_extensions.dart';

class GoogleMapsPlatformCameraUpdate extends PlatformCameraUpdate {
  GoogleMapsPlatformCameraUpdate() : super.implementation();

  @override
  CameraUpdate newCameraPosition(CameraPosition cameraPosition) {
    return GoogleMapsCameraUpdate._(
      google_maps.CameraUpdate.newCameraPosition(
        cameraPosition.googleMapsCameraPosition,
      ),
    );
  }

  @override
  CameraUpdate newLatLng(LatLng latLng) {
    return GoogleMapsCameraUpdate._(
      google_maps.CameraUpdate.newLatLng(
        latLng.googleMapsLatLng,
      ),
    );
  }

  @override
  CameraUpdate newLatLngBounds(LatLngBounds bounds, double padding) {
    return GoogleMapsCameraUpdate._(
      google_maps.CameraUpdate.newLatLngBounds(
        bounds.googleMapsLatLngBounds,
        padding,
      ),
    );
  }

  @override
  CameraUpdate newLatLngZoom(LatLng latLng, double zoom) {
    return GoogleMapsCameraUpdate._(
      google_maps.CameraUpdate.newLatLngZoom(
        latLng.googleMapsLatLng,
        zoom,
      ),
    );
  }

  @override
  CameraUpdate zoomBy(double amount) {
    return GoogleMapsCameraUpdate._(
      google_maps.CameraUpdate.zoomBy(amount),
    );
  }

  @override
  CameraUpdate zoomIn() {
    return GoogleMapsCameraUpdate._(
      google_maps.CameraUpdate.zoomIn(),
    );
  }

  @override
  CameraUpdate zoomOut() {
    return GoogleMapsCameraUpdate._(
      google_maps.CameraUpdate.zoomOut(),
    );
  }

  @override
  CameraUpdate zoomTo(double zoom) {
    return GoogleMapsCameraUpdate._(
      google_maps.CameraUpdate.zoomTo(zoom),
    );
  }
}

class GoogleMapsCameraUpdate extends CameraUpdate {
  const GoogleMapsCameraUpdate._(this.googleMapsCameraUpdate);
  final google_maps.CameraUpdate googleMapsCameraUpdate;
}
