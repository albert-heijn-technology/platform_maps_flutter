import 'dart:ui';

import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart'
    as google_maps;
import 'package:platform_maps_flutter_google_android/src/google_maps_bitmap_descriptor.dart';
import 'package:platform_maps_flutter_google_android/src/google_maps_platform_controller.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';

import 'package:platform_maps_flutter_google_android/src/google_map_original.dart'
    as google_map_original;

extension GoogleMapsLatLngMapper on google_maps.LatLng {
  LatLng get platformLatLng {
    return LatLng(latitude, longitude);
  }
}

extension LatLngMapper on LatLng {
  google_maps.LatLng get googleMapsLatLng {
    return google_maps.LatLng(latitude, longitude);
  }
}

extension on List<LatLng> {
  List<google_maps.LatLng> get googleLatLngList {
    return map((latLng) => latLng.googleMapsLatLng).toList();
  }
}

extension LatLngBoundsMapper on LatLngBounds {
  google_maps.LatLngBounds get googleMapsLatLngBounds {
    return google_maps.LatLngBounds(
      southwest: southwest.googleMapsLatLng,
      northeast: northeast.googleMapsLatLng,
    );
  }
}

extension GoogleMapsLatLngBoundsMapper on google_maps.LatLngBounds {
  LatLngBounds get platformLatLngBounds {
    return LatLngBounds(
      southwest: southwest.platformLatLng,
      northeast: northeast.platformLatLng,
    );
  }
}

extension MarkersMapper on Set<Marker> {
  Set<google_maps.Marker> get googleMapsMarkerSet {
    return map((marker) => marker.googleMapsMarker).toSet();
  }
}

extension on Marker {
  google_maps.Marker get googleMapsMarker {
    return google_maps.Marker(
      markerId: markerId.googleMapsMarkerId,
      alpha: alpha,
      anchor: anchor,
      draggable: draggable,
      infoWindow: infoWindow.googleMapsInfoWindow,
      onTap: onTap,
      icon: (icon as GoogleMapsBitmapDescriptor?)?.descriptor ??
          google_maps.BitmapDescriptor.defaultMarker,
      visible: visible,
      onDragEnd: onDragEnd != null
          ? (google_maps.LatLng latLng) =>
              _onGoogleMarkerDragEnd(latLng, onDragEnd)
          : null,
      position: position.googleMapsLatLng,
    );
  }

  static _onGoogleMarkerDragEnd(
    google_maps.LatLng latLng,
    Function? onDragEnd,
  ) {
    onDragEnd?.call(latLng.platformLatLng);
  }
}

extension MarkerIdMapper on MarkerId {
  google_maps.MarkerId get googleMapsMarkerId {
    return google_maps.MarkerId(value);
  }
}

extension on InfoWindow {
  google_maps.InfoWindow get googleMapsInfoWindow => google_maps.InfoWindow(
        anchor: anchor ?? const Offset(0, 0),
        onTap: onTap,
        snippet: snippet,
        title: title,
      );
}

extension CameraMapper on CameraPosition {
  google_maps.CameraPosition get googleMapsCameraPosition {
    return google_maps.CameraPosition(
      target: target.googleMapsLatLng,
      bearing: bearing,
      tilt: tilt,
      zoom: zoom,
    );
  }
}

extension GoogleMapsCameraMapper on google_maps.CameraPosition {
  CameraPosition get platformCameraPosition {
    return CameraPosition(
      target: target.platformLatLng,
      bearing: bearing,
      tilt: tilt,
      zoom: zoom,
    );
  }
}

extension PolylinesMapper on Set<Polyline> {
  Set<google_maps.Polyline> get googleMapsPolylineSet {
    return map((polyline) => polyline.googleMapsPolyline).toSet();
  }
}

extension on Polyline {
  google_maps.Polyline get googleMapsPolyline {
    return google_maps.Polyline(
      polylineId: polylineId.googleMapsPolylineId,
      color: color,
      consumeTapEvents: consumeTapEvents,
      startCap: polylineCap.googlePolylineCap,
      endCap: polylineCap.googlePolylineCap,
      jointType: jointType.googleMapsJointType,
      onTap: onTap,
      patterns: patterns.googleMapsPatternItemList,
      points: points.googleLatLngList,
      visible: visible,
      width: width,
    );
  }
}

extension on PolylineId {
  google_maps.PolylineId get googleMapsPolylineId {
    return google_maps.PolylineId(value);
  }
}

extension on Cap {
  static const Map<Cap, google_maps.Cap> googleMapsCaps = {
    Cap.buttCap: google_maps.Cap.buttCap,
    Cap.roundCap: google_maps.Cap.roundCap,
    Cap.squareCap: google_maps.Cap.squareCap,
  };

  google_maps.Cap get googlePolylineCap {
    return googleMapsCaps[this]!;
  }
}

extension on JointType {
  static const List<google_maps.JointType> googleMapsJointTypes = [
    google_maps.JointType.mitered,
    google_maps.JointType.bevel,
    google_maps.JointType.round,
  ];

  google_maps.JointType get googleMapsJointType {
    return googleMapsJointTypes[value];
  }
}

extension on List<PatternItem> {
  List<google_maps.PatternItem> get googleMapsPatternItemList {
    return map((patternItem) => patternItem.googleMapsPatternItem).toList();
  }
}

extension on PatternItem {
  google_maps.PatternItem get googleMapsPatternItem {
    return switch (this) {
      DotPatternItem() => google_maps.PatternItem.dot,
      DashPatternItem dash => google_maps.PatternItem.dash(dash.length),
      GapPatternItem gap => google_maps.PatternItem.gap(gap.length),
    };
  }
}

extension PolygonMapper on Set<Polygon> {
  Set<google_maps.Polygon> get googleMapsPolygonSet {
    return map((polygon) => polygon.googleMapsPolygon).toSet();
  }
}

extension on Polygon {
  google_maps.Polygon get googleMapsPolygon {
    return google_maps.Polygon(
      polygonId: google_maps.PolygonId(polygonId.value),
      consumeTapEvents: consumeTapEvents,
      fillColor: fillColor,
      onTap: onTap,
      points: points.googleLatLngList,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      visible: visible,
    );
  }
}

extension CircleMapper on Set<Circle> {
  Set<google_maps.Circle> get googleMapsCircleSet {
    return map((circle) => circle.googleMapsCircle).toSet();
  }
}

extension on Circle {
  google_maps.Circle get googleMapsCircle {
    return google_maps.Circle(
      circleId: google_maps.CircleId(circleId.value),
      consumeTapEvents: consumeTapEvents,
      fillColor: fillColor,
      onTap: onTap,
      center: center.googleMapsLatLng,
      radius: radius,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      visible: visible,
    );
  }
}

extension ZoomMapper on MinMaxZoomPreference {
  google_maps.MinMaxZoomPreference get googleMapsZoomPreference {
    return google_maps.MinMaxZoomPreference(minZoom, maxZoom);
  }
}

extension GoogleMapsControllerMappers
    on google_map_original.GoogleMapController {
  PlatformMapController get platformMapController {
    return PlatformMapController(GoogleMapsPlatformController(this));
  }
}
