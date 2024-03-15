import 'dart:typed_data';

import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';

class PlatformMapController {
  final PlatformMapsPlatformController platformController;

  PlatformMapController(this.platformController);

  /// Programmatically show the Info Window for a [Marker].
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [hideMarkerInfoWindow] to hide the Info Window.
  ///   * [isMarkerInfoWindowShown] to check if the Info Window is showing.
  Future<void> showMarkerInfoWindow(MarkerId markerId) =>
      platformController.showMarkerInfoWindow(markerId);

  /// Programmatically hide the Info Window for a [Marker].
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [showMarkerInfoWindow] to show the Info Window.
  ///   * [isMarkerInfoWindowShown] to check if the Info Window is showing.
  Future<void> hideMarkerInfoWindow(MarkerId markerId) =>
      platformController.hideMarkerInfoWindow(markerId);

  /// Returns `true` when the [InfoWindow] is showing, `false` otherwise.
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [showMarkerInfoWindow] to show the Info Window.
  ///   * [hideMarkerInfoWindow] to hide the Info Window.
  Future<bool> isMarkerInfoWindowShown(MarkerId markerId) =>
      platformController.isMarkerInfoWindowShown(markerId);

  /// Starts an animated change of the map camera position.
  ///
  /// The returned [Future] completes after the change has been started on the
  /// platform side.
  Future<void> animateCamera(cameraUpdate) => platformController.animateCamera(cameraUpdate);

  /// Changes the map camera position.
  ///
  /// The returned [Future] completes after the change has been made on the
  /// platform side.
  Future<void> moveCamera(cameraUpdate) => platformController.moveCamera(cameraUpdate);

  /// Return [LatLngBounds] defining the region that is visible in a map.
  Future<LatLngBounds> getVisibleRegion() => platformController.getVisibleRegion();

  /// Returns the image bytes of the map
  Future<Uint8List?> takeSnapshot() => platformController.takeSnapshot();
}
