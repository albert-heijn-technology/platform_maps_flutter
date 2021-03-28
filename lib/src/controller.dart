part of platform_maps_flutter;

class PlatformMapController {
  appleMaps.AppleMapController? appleController;
  googleMaps.GoogleMapController? googleController;

  PlatformMapController(dynamic controller) {
    if (controller.runtimeType == googleMaps.GoogleMapController) {
      this.googleController = controller;
    } else if (controller.runtimeType == appleMaps.AppleMapController) {
      this.appleController = controller;
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
    if (Platform.isAndroid) {
      return googleController!
          .showMarkerInfoWindow(markerId.googleMapsMarkerId);
    } else if (Platform.isIOS) {
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
    if (Platform.isAndroid) {
      return googleController!
          .hideMarkerInfoWindow(markerId.googleMapsMarkerId);
    } else if (Platform.isIOS) {
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
    if (Platform.isAndroid) {
      return googleController!
          .isMarkerInfoWindowShown(markerId.googleMapsMarkerId);
    } else if (Platform.isIOS) {
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
    if (Platform.isIOS) {
      return this.appleController!.animateCamera(cameraUpdate);
    } else if (Platform.isAndroid) {
      return this.googleController!.animateCamera(cameraUpdate);
    }
    throw ('Platform not supported.');
  }

  /// Changes the map camera position.
  ///
  /// The returned [Future] completes after the change has been made on the
  /// platform side.
  Future<void> moveCamera(cameraUpdate) async {
    if (Platform.isIOS) {
      return this.appleController!.moveCamera(cameraUpdate);
    } else if (Platform.isAndroid) {
      return this.googleController!.moveCamera(cameraUpdate);
    }
  }

  /// Return [LatLngBounds] defining the region that is visible in a map.
  Future<LatLngBounds> getVisibleRegion() async {
    late LatLngBounds _bounds;
    if (Platform.isIOS) {
      appleMaps.LatLngBounds appleBounds =
          await this.appleController!.getVisibleRegion();
      _bounds = LatLngBounds._fromAppleLatLngBounds(appleBounds);
    } else if (Platform.isAndroid) {
      googleMaps.LatLngBounds googleBounds =
          await this.googleController!.getVisibleRegion();
      _bounds = LatLngBounds._fromGoogleLatLngBounds(googleBounds);
    }
    return _bounds;
  }
}
