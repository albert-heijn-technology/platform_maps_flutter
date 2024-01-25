part of platform_maps_flutter;

/// The position of the map "camera", the view point from which the world is
/// shown in the map view. Aggregates the camera's [target] geographical
/// location, its [zoom] level, [pitch] angle, and [heading].
class CameraPosition {
  const CameraPosition({
    required this.target,
    this.bearing = 0.0,
    this.tilt = 0.0,
    this.zoom = 0,
    this.isFlutterMap = false,
  });

  /// The camera's bearing in degrees, measured clockwise from north.
  ///
  /// A bearing of 0.0, the default, means the camera points north.
  /// A bearing of 90.0 means the camera points east.
  final double bearing;

  /// The geographical location that the camera is pointing at.
  final LatLng target;

  // In degrees where 0 is looking straight down. Pitch may be clamped to an appropriate value.
  final double tilt;

  final bool isFlutterMap;

  /// The zoom level of the camera.
  ///
  /// A zoom of 0.0, the default, means the screen width of the world is 256.
  /// Adding 1.0 to the zoom level doubles the screen width of the map. So at
  /// zoom level 3.0, the screen width of the world is 2³x256=2048.
  ///
  /// Larger zoom levels thus means the camera is placed closer to the surface
  /// of the Earth, revealing more detail in a narrower geographical region.
  ///
  /// The supported zoom level range depends on the map data and device. Values
  /// beyond the supported range are allowed, but on applying them to a map they
  /// will be silently clamped to the supported range.
  final double zoom;

  appleMaps.CameraPosition get appleMapsCameraPosition {
    return appleMaps.CameraPosition(
      target: this.target.appleLatLng,
      heading: this.bearing,
      pitch: this.tilt,
      zoom: this.zoom,
    );
  }

  googleMaps.CameraPosition get googleMapsCameraPosition {
    return googleMaps.CameraPosition(
      target: this.target.googleLatLng,
      bearing: this.bearing,
      tilt: this.tilt,
      zoom: this.zoom,
    );
  }

  static CameraPosition fromAppleMapCameraPosition(
      appleMaps.CameraPosition cameraPosition) {
    return CameraPosition(
      target: LatLng._fromAppleLatLng(cameraPosition.target),
      bearing: cameraPosition.heading,
      tilt: cameraPosition.pitch,
      zoom: cameraPosition.zoom,
    );
  }

  static CameraPosition fromGoogleMapCameraPosition(
      googleMaps.CameraPosition cameraPosition) {
    return CameraPosition(
      target: LatLng._fromGoogleLatLng(cameraPosition.target),
      bearing: cameraPosition.bearing,
      tilt: cameraPosition.tilt,
      zoom: cameraPosition.zoom,
    );
  }
}

class CameraUpdate {
  CameraUpdate._(this._json);

  /// Returns a camera update that moves the camera to the specified position.
  static newCameraPosition(CameraPosition cameraPosition) {
    if (cameraPosition.isFlutterMap) {
      return {
        "latLng": latlong2.LatLng(
            cameraPosition.target.latitude, cameraPosition.target.longitude),
        "zoom": cameraPosition.zoom,
        "bearing": cameraPosition.bearing
      };
    } else if (Platform.isIOS) {
      return appleMaps.CameraUpdate.newCameraPosition(
          cameraPosition.appleMapsCameraPosition);
    } else if (Platform.isAndroid) {
      return googleMaps.CameraUpdate.newCameraPosition(
          cameraPosition.googleMapsCameraPosition);
    }
  }

  /// Returns a camera update that moves the camera target to the specified geographical location.
  static newLatLng(LatLng latLng) {
    if (Platform.isIOS) {
      return appleMaps.CameraUpdate.newLatLng(latLng.appleLatLng);
    } else if (Platform.isAndroid) {
      return googleMaps.CameraUpdate.newLatLng(latLng.googleLatLng);
    }
  }

  /// Returns a camera update that moves the camera target to the specified geographical location and zoom level.
  static newLatLngZoom(LatLng latLng, double zoom) {
    if (Platform.isIOS) {
      return appleMaps.CameraUpdate.newLatLngZoom(latLng.appleLatLng, zoom);
    } else if (Platform.isAndroid) {
      return googleMaps.CameraUpdate.newLatLngZoom(latLng.googleLatLng, zoom);
    }
  }

  /// Returns a camera update that transforms the camera so that
  /// the specified geographical bounding box is centered in the map
  /// view at the greatest possible zoom level.
  /// A non-zero [padding] insets the bounding box from the map view's edges.
  /// The camera's new tilt and bearing will both be 0.0.
  static newLatLngBounds(LatLngBounds bounds, double padding) {
    if (Platform.isIOS) {
      return appleMaps.CameraUpdate.newLatLngBounds(
          bounds.appleLatLngBounds, padding);
    } else if (Platform.isAndroid) {
      return googleMaps.CameraUpdate.newLatLngBounds(
          bounds.googleLatLngBounds, padding);
    }
  }

  /// Returns a camera update that modifies the camera zoom level by the specified amount.
  /// The optional [focus] is a screen point whose underlying geographical location
  /// should be invariant, if possible, by the movement.
  static zoomBy(double amount) {
    if (Platform.isIOS) {
      return appleMaps.CameraUpdate.zoomBy(amount);
    } else if (Platform.isAndroid) {
      return googleMaps.CameraUpdate.zoomBy(amount);
    }
  }

  /// Returns a camera update that zooms the camera in,
  ///  bringing the camera closer to the surface of the Earth.
  ///
  /// Equivalent to the result of calling zoomBy(1.0).
  static zoomIn() {
    if (Platform.isIOS) {
      return appleMaps.CameraUpdate.zoomIn();
    } else if (Platform.isAndroid) {
      return googleMaps.CameraUpdate.zoomIn();
    }
  }

  /// Returns a camera update that zooms the camera out,
  /// bringing the camera further away from the surface of the Earth.
  ///
  /// Equivalent to the result of calling zoomBy(-1.0).
  static zoomOut() {
    if (Platform.isIOS) {
      return appleMaps.CameraUpdate.zoomOut();
    } else if (Platform.isAndroid) {
      return googleMaps.CameraUpdate.zoomOut();
    }
  }

  /// Returns a camera update that sets the camera zoom level.
  static zoomTo(double zoom) {
    if (Platform.isIOS) {
      return appleMaps.CameraUpdate.zoomTo(zoom);
    } else if (Platform.isAndroid) {
      return googleMaps.CameraUpdate.zoomTo(zoom);
    }
  }

  final dynamic _json;

  /// Converts this object to something serializable in JSON.
  dynamic toJson() => _json;
}
