part of platform_maps_flutter;

class PlatformMapController {
  appleMaps.AppleMapController? appleController;
  googleMaps.GoogleMapController? googleController;
  flutterMaps.MapController? flutterController;

  PlatformMapController(dynamic controller) {
    if (controller.runtimeType == googleMaps.GoogleMapController) {
      this.googleController = controller;
    } else if (controller.runtimeType == appleMaps.AppleMapController) {
      this.appleController = controller;
    } else if (controller.runtimeType == flutterMaps.MapController) {
      this.flutterController = controller;
    }
  }

  /// Programmatically show the Info Window for a [Marker].
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [hideMarkerInfoWindow] to hide the Info Window.
  ///   * [isMarkerInfoWindowShown] to check if the Info Window is showing.
  Future<void> showMarkerInfoWindow(MarkerId markerId) {
    if (this.googleController != null) {
      return googleController!
          .showMarkerInfoWindow(markerId.googleMapsMarkerId);
    } else if (this.appleController != null) {
      return appleController!
          .showMarkerInfoWindow(markerId.appleMapsAnnoationId);
    }
    throw ('Platform not supported.');
  }

  /// Programmatically hide the Info Window for a [Marker].
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [showMarkerInfoWindow] to show the Info Window.
  ///   * [isMarkerInfoWindowShown] to check if the Info Window is showing.
  Future<void> hideMarkerInfoWindow(MarkerId markerId) {
    if (this.googleController != null) {
      return googleController!
          .hideMarkerInfoWindow(markerId.googleMapsMarkerId);
    } else if (this.appleController != null) {
      return appleController!
          .hideMarkerInfoWindow(markerId.appleMapsAnnoationId);
    }
    throw ('Platform not supported.');
  }

  /// Returns `true` when the [InfoWindow] is showing, `false` otherwise.
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [showMarkerInfoWindow] to show the Info Window.
  ///   * [hideMarkerInfoWindow] to hide the Info Window.
  Future<bool> isMarkerInfoWindowShown(MarkerId markerId) async {
    if (this.googleController != null) {
      return googleController!
          .isMarkerInfoWindowShown(markerId.googleMapsMarkerId);
    } else if (this.appleController != null) {
      return await appleController!
              .isMarkerInfoWindowShown(markerId.appleMapsAnnoationId) ??
          false;
    }
    throw ('Platform not supported.');
  }

  /// Starts an animated change of the map camera position.
  ///
  /// The returned [Future] completes after the change has been started on the
  /// platform side.
  Future<void> animateCamera(cameraUpdate) async {
    if (this.appleController != null) {
      return this.appleController!.animateCamera(cameraUpdate);
    } else if (this.googleController != null)
      return this.googleController!.animateCamera(cameraUpdate);
    else {
      return Future.value(this
          .flutterController!
          .move(cameraUpdate['latLng'], cameraUpdate['zoom']));
    }
  }

  /// Changes the map camera position.
  ///
  /// The returned [Future] completes after the change has been made on the
  /// platform side.
  Future<void> moveCamera(cameraUpdate) async {
    if (this.appleController != null) {
      return this.appleController!.moveCamera(cameraUpdate);
    } else if (this.googleController != null)
      return this.googleController!.moveCamera(cameraUpdate);
    else {
      return Future.value(this
          .flutterController!
          .move(cameraUpdate['latLng'], cameraUpdate['zoom']));
    }
  }

  /// Return [LatLngBounds] defining the region that is visible in a map.
  Future<LatLngBounds> getVisibleRegion() async {
    late LatLngBounds _bounds;
    if (this.appleController != null) {
      appleMaps.LatLngBounds appleBounds =
          await this.appleController!.getVisibleRegion();
      _bounds = LatLngBounds._fromAppleLatLngBounds(appleBounds);
    } else if (this.googleController != null) {
      googleMaps.LatLngBounds googleBounds =
          await this.googleController!.getVisibleRegion();
      _bounds = LatLngBounds._fromGoogleLatLngBounds(googleBounds);
    } else {
      _bounds = LatLngBounds._fromFlutterLatLngBounds(
          this.flutterController!.camera.visibleBounds);
    }
    return _bounds;
  }
}
