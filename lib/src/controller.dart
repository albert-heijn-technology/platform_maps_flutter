part of flutter_platform_maps;

class PlatformMapController {
  appleMaps.AppleMapController appleController;
  googleMaps.GoogleMapController googleController;

  PlatformMapController(dynamic controller) {
    if (controller.runtimeType == googleMaps.GoogleMapController) {
      this.googleController = controller;
    } else if (controller.runtimeType == appleMaps.AppleMapController) {
      this.appleController = controller;
    }
  }

  /// Starts an animated change of the map camera position.
  ///
  /// The returned [Future] completes after the change has been started on the
  /// platform side.
  Future<void> animateCamera(cameraUpdate) async {
    if (Platform.isIOS) {
      return this.appleController.animateCamera(cameraUpdate);
    } else if (Platform.isAndroid) {
      return this.googleController.animateCamera(cameraUpdate);
    }
  }

  /// Changes the map camera position.
  ///
  /// The returned [Future] completes after the change has been made on the
  /// platform side.
  Future<void> moveCamera(CameraUpdate cameraUpdate) async {
    if (Platform.isIOS) {
      return this.appleController.moveCamera(cameraUpdate);
    } else if (Platform.isAndroid) {
      return this.googleController.moveCamera(cameraUpdate);
    }
  }

  /// Return [LatLngBounds] defining the region that is visible in a map.
  Future<LatLngBounds> getVisibleRegion() async {
    LatLngBounds _bounds;
    if (Platform.isIOS) {
      appleMaps.LatLngBounds appleBounds =
          await this.appleController.getVisibleRegion();
      _bounds = LatLngBounds._fromAppleLatLngBounds(appleBounds);
    } else if (Platform.isAndroid) {
      googleMaps.LatLngBounds googleBounds =
          await this.googleController.getVisibleRegion();
      _bounds = LatLngBounds._fromGoogleLatLngBounds(googleBounds);
    }
    return _bounds;
  }
}
