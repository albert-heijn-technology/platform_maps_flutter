import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:platform_maps_flutter_apple/src/mapper_extensions.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple_maps;

class AppleMapsWidget extends PlatformMapsPlatformWidget {
  AppleMapsWidget(PlatformMapsPlatformWidgetCreationParams params) : super.implementation(params);

  @override
  Widget build(BuildContext context) {
    return _PlatformMap(params: params);
  }
}

class _PlatformMap extends StatefulWidget {
  const _PlatformMap({
    required this.params,
  });

  final PlatformMapsPlatformWidgetCreationParams params;

  /// Callback method for when the map is ready to be used.
  ///
  /// Used to receive a [AppleMapController] for this [AppleMap].
  MapCreatedCallback? get onMapCreated => params.onMapCreated;

  /// The initial position of the map's camera.
  CameraPosition get initialCameraPosition => params.initialCameraPosition;

  /// True if the map should show a compass when rotated.
  bool get compassEnabled => params.compassEnabled;

  /// Type of map tiles to be rendered.
  MapType get mapType => params.mapType;

  /// Preferred bounds for the camera zoom level.
  ///
  /// Actual bounds depend on map data and device.
  MinMaxZoomPreference get minMaxZoomPreference => params.minMaxZoomPreference;

  /// True if the map view should respond to rotate gestures.
  bool get rotateGesturesEnabled => params.rotateGesturesEnabled;

  /// True if the map view should respond to scroll gestures.
  bool get scrollGesturesEnabled => params.scrollGesturesEnabled;

  /// True if the map view should show zoom controls. This includes two buttons
  /// to zoom in and zoom out. The default value is to show zoom controls.
  ///
  /// This is only supported on Android. And this field is silently ignored on iOS.
  bool get zoomControlsEnabled => params.zoomControlsEnabled;

  /// True if the map view should respond to zoom gestures.
  bool get zoomGesturesEnabled => params.zoomGesturesEnabled;

  /// True if the map view should respond to tilt gestures.
  bool get tiltGesturesEnabled => params.tiltGesturesEnabled;

  /// Padding to be set on map.
  EdgeInsets get padding => params.padding;

  /// Markers to be placed on the map.
  Set<Marker> get markers => params.markers;

  /// Polygons to be placed on the map.
  Set<Polygon> get polygons => params.polygons;

  /// Polylines to be placed on the map.
  Set<Polyline> get polylines => params.polylines;

  /// Circles to be placed on the map.
  Set<Circle> get circles => params.circles;

  /// Called when the camera starts moving.
  ///
  /// This can be initiated by the following:
  /// 1. Non-gesture animation initiated in response to user actions.
  ///    For example: zoom buttons, my location button, or marker clicks.
  /// 2. Programmatically initiated animation.
  /// 3. Camera motion initiated in response to user gestures on the map.
  ///    For example: pan, tilt, pinch to zoom, or rotate.
  VoidCallback? get onCameraMoveStarted => params.onCameraMoveStarted;

  /// Called repeatedly as the camera continues to move after an
  /// onCameraMoveStarted call.
  ///
  /// This may be called as often as once every frame and should
  /// not perform expensive operations.
  CameraPositionCallback? get onCameraMove => params.onCameraMove;

  /// Called when camera movement has ended, there are no pending
  /// animations and the user has stopped interacting with the map.
  VoidCallback? get onCameraIdle => params.onCameraIdle;

  /// Called every time a [PlatformMap] is tapped.
  ArgumentCallback<LatLng>? get onTap => params.onTap;

  /// Called every time a [PlatformMap] is long pressed.
  ArgumentCallback<LatLng>? get onLongPress => params.onLongPress;

  /// True if a "My Location" layer should be shown on the map.
  ///
  /// This layer includes a location indicator at the current device location,
  /// as well as a My Location button.
  /// * The indicator is a small blue dot if the device is stationary, or a
  /// chevron if the device is moving.
  /// * The My Location button animates to focus on the user's current location
  /// if the user's location is currently known.
  ///
  /// Enabling this feature requires adding location permissions to both native
  /// platforms of your app.
  /// * On Android add either
  /// `<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />`
  /// or `<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />`
  /// to your `AndroidManifest.xml` file. `ACCESS_COARSE_LOCATION` returns a
  /// location with an accuracy approximately equivalent to a city block, while
  /// `ACCESS_FINE_LOCATION` returns as precise a location as possible, although
  /// it consumes more battery power. You will also need to request these
  /// permissions during run-time. If they are not granted, the My Location
  /// feature will fail silently.
  /// * On iOS add a `NSLocationWhenInUseUsageDescription` key to your
  /// `Info.plist` file. This will automatically prompt the user for permissions
  /// when the map tries to turn on the My Location layer.
  bool get myLocationEnabled => params.myLocationEnabled;

  /// Enables or disables the my-location button.
  ///
  /// The my-location button causes the camera to move such that the user's
  /// location is in the center of the map. If the button is enabled, it is
  /// only shown when the my-location layer is enabled.
  ///
  /// By default, the my-location button is enabled (and hence shown when the
  /// my-location layer is enabled).
  ///
  /// See also:
  ///   * [myLocationEnabled] parameter.
  bool get myLocationButtonEnabled => params.myLocationButtonEnabled;

  /// Enables or disables the traffic layer of the map
  bool get trafficEnabled => params.trafficEnabled;

  /// Which gestures should be consumed by the map.
  ///
  /// It is possible for other gesture recognizers to be competing with the map on pointer
  /// events, e.g if the map is inside a [ListView] the [ListView] will want to handle
  /// vertical drags. The map will claim gestures that are recognized by any of the
  /// recognizers on this list.
  ///
  /// When this set is empty, the map will only handle pointer events for gestures that
  /// were not claimed by any other gesture recognizer.
  Set<Factory<OneSequenceGestureRecognizer>> get gestureRecognizers => params.gestureRecognizers;
  @override
  _PlatformMapState createState() => _PlatformMapState();
}

class _PlatformMapState extends State<_PlatformMap> {
  @override
  Widget build(BuildContext context) {
    return apple_maps.AppleMap(
      initialCameraPosition: widget.initialCameraPosition.appleMapsCameraPosition,
      compassEnabled: widget.compassEnabled,
      mapType: _getMapType(),
      padding: widget.padding,
      annotations: widget.markers.appleMapsAnnotationSet,
      polylines: widget.polylines.appleMapsPolylineSet,
      polygons: widget.polygons.appleMapsPolygonSet,
      circles: widget.circles.appleMapsCircleSet,
      gestureRecognizers: widget.gestureRecognizers,
      onCameraIdle: widget.onCameraIdle,
      myLocationButtonEnabled: widget.myLocationButtonEnabled,
      myLocationEnabled: widget.myLocationEnabled,
      onCameraMoveStarted: widget.onCameraMoveStarted,
      pitchGesturesEnabled: widget.tiltGesturesEnabled,
      rotateGesturesEnabled: widget.rotateGesturesEnabled,
      zoomGesturesEnabled: widget.zoomGesturesEnabled,
      scrollGesturesEnabled: widget.scrollGesturesEnabled,
      onMapCreated: _onMapCreated,
      onCameraMove: _onCameraMove,
      onTap: _onTap,
      onLongPress: _onLongPress,
      trafficEnabled: widget.trafficEnabled,
      minMaxZoomPreference: widget.minMaxZoomPreference.appleMapsZoomPreference,
    );
  }

  void _onMapCreated(apple_maps.AppleMapController controller) {
    widget.onMapCreated?.call(controller.platformMapController);
  }

  void _onCameraMove(apple_maps.CameraPosition cameraPosition) {
    widget.onCameraMove?.call(cameraPosition.platformCameraPosition);
  }

  void _onTap(apple_maps.LatLng position) {
    widget.onTap?.call(position.platformLatLng);
  }

  void _onLongPress(apple_maps.LatLng position) {
    widget.onLongPress?.call(position.platformLatLng);
  }

  apple_maps.MapType _getMapType() {
    if (widget.mapType == MapType.normal) {
      return apple_maps.MapType.standard;
    } else if (widget.mapType == MapType.satellite) {
      return apple_maps.MapType.satellite;
    } else if (widget.mapType == MapType.hybrid) {
      return apple_maps.MapType.hybrid;
    }
    return apple_maps.MapType.standard;
  }
}
