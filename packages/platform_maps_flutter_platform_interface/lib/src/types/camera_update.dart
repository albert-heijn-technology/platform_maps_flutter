import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';
import 'package:platform_maps_flutter_platform_interface/src/platform_camera_update.dart';

abstract class CameraUpdate {
  /// Returns a camera update that moves the camera to the specified position.
  static CameraUpdate newCameraPosition(CameraPosition cameraPosition) =>
      PlatformCameraUpdate().newCameraPosition(cameraPosition);

  /// Returns a camera update that moves the camera target to the specified geographical location.
  static CameraUpdate newLatLng(LatLng latLng) => PlatformCameraUpdate().newLatLng(latLng);

  /// Returns a camera update that moves the camera target to the specified geographical location and zoom level.
  static CameraUpdate newLatLngZoom(LatLng latLng, double zoom) =>
      PlatformCameraUpdate().newLatLngZoom(latLng, zoom);

  /// Returns a camera update that transforms the camera so that
  /// the specified geographical bounding box is centered in the map
  /// view at the greatest possible zoom level.
  /// A non-zero [padding] insets the bounding box from the map view's edges.
  /// The camera's new tilt and bearing will both be 0.0.
  static CameraUpdate newLatLngBounds(LatLngBounds bounds, double padding) =>
      PlatformCameraUpdate().newLatLngBounds(bounds, padding);

  /// Returns a camera update that modifies the camera zoom level by the specified amount.
  /// The optional [focus] is a screen point whose underlying geographical location
  /// should be invariant, if possible, by the movement.
  static CameraUpdate zoomBy(double amount) => PlatformCameraUpdate().zoomBy(amount);

  /// Returns a camera update that zooms the camera in,
  ///  bringing the camera closer to the surface of the Earth.
  ///
  /// Equivalent to the result of calling zoomBy(1.0).
  static CameraUpdate zoomIn() => PlatformCameraUpdate().zoomIn();

  /// Returns a camera update that zooms the camera out,
  /// bringing the camera further away from the surface of the Earth.
  ///
  /// Equivalent to the result of calling zoomBy(-1.0).
  static CameraUpdate zoomOut() => PlatformCameraUpdate().zoomOut();

  /// Returns a camera update that sets the camera zoom level.
  static CameraUpdate zoomTo(double zoom) => PlatformCameraUpdate().zoomTo(zoom);
}
