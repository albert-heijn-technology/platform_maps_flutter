import 'dart:ui';

import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple_maps;
import 'package:platform_maps_flutter_apple/src/apple_maps_platform_controller.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';

extension AppleMapsLatLngMapper on apple_maps.LatLng {
  LatLng get platformLatLng {
    return LatLng(latitude, longitude);
  }
}

extension LatLngMapper on LatLng {
  apple_maps.LatLng get appleMapsLatLng {
    return apple_maps.LatLng(latitude, longitude);
  }
}

extension on List<LatLng> {
  List<apple_maps.LatLng> get appleLatLngList {
    return map((latLng) => latLng.appleMapsLatLng).toList();
  }
}

extension LatLngBoundsMapper on LatLngBounds {
  apple_maps.LatLngBounds get appleMapsLatLngBounds {
    return apple_maps.LatLngBounds(
      southwest: southwest.appleMapsLatLng,
      northeast: northeast.appleMapsLatLng,
    );
  }
}

extension AppleMapsLatLngBoundsMapper on apple_maps.LatLngBounds {
  LatLngBounds get platformLatLngBounds {
    return LatLngBounds(
      southwest: southwest.platformLatLng,
      northeast: northeast.platformLatLng,
    );
  }
}

extension MarkersMapper on Set<Marker> {
  Set<apple_maps.Annotation> get appleMapsAnnotationSet {
    return map((marker) => marker.appleMapsAnnotation).toSet();
  }
}

extension on Marker {
  apple_maps.Annotation get appleMapsAnnotation => apple_maps.Annotation(
        annotationId: markerId.appleMapsAnnotationId,
        alpha: alpha,
        anchor: anchor,
        draggable: draggable,
        infoWindow: infoWindow.appleMapsInfoWindow,
        onTap: onTap,
        icon: icon?.bitmapDescriptor ?? apple_maps.BitmapDescriptor.defaultAnnotation,
        visible: visible,
        onDragEnd:
            onDragEnd != null ? (apple_maps.LatLng latLng) => _onDragEnd(latLng, onDragEnd) : null,
        position: position.appleMapsLatLng,
      );

  static _onDragEnd(apple_maps.LatLng latLng, Function? onDragEnd) {
    onDragEnd?.call(latLng.platformLatLng);
  }
}

extension MarkerIdMapper on MarkerId {
  apple_maps.AnnotationId get appleMapsAnnotationId {
    return apple_maps.AnnotationId(value);
  }
}

extension on InfoWindow {
  apple_maps.InfoWindow get appleMapsInfoWindow => apple_maps.InfoWindow(
        anchor: anchor ?? const Offset(0, 0),
        onTap: onTap,
        snippet: snippet,
        title: title,
      );
}

extension CameraMapper on CameraPosition {
  apple_maps.CameraPosition get appleMapsCameraPosition {
    return apple_maps.CameraPosition(
      target: target.appleMapsLatLng,
      heading: bearing,
      pitch: tilt,
      zoom: zoom,
    );
  }
}

extension AppleMapsCameraMapper on apple_maps.CameraPosition {
  CameraPosition get platformCameraPosition {
    return CameraPosition(
      target: target.platformLatLng,
      bearing: heading,
      tilt: pitch,
      zoom: zoom,
    );
  }
}

extension PolylinesMapper on Set<Polyline> {
  Set<apple_maps.Polyline> get appleMapsPolylineSet {
    return map((polyline) => polyline.appleMapsPolyline).toSet();
  }
}

extension on Polyline {
  apple_maps.Polyline get appleMapsPolyline {
    return apple_maps.Polyline(
      polylineId: polylineId.appleMapsPolylineId,
      color: color,
      consumeTapEvents: consumeTapEvents,
      polylineCap: polylineCap.applePolylineCap,
      jointType: jointType.appleMapsJointType,
      onTap: onTap,
      patterns: patterns.appleMapsPatternItemList,
      points: points.appleLatLngList,
      visible: visible,
      width: width,
    );
  }
}

extension on PolylineId {
  apple_maps.PolylineId get appleMapsPolylineId {
    return apple_maps.PolylineId(value);
  }
}

extension on Cap {
  static const Map<Cap, apple_maps.Cap> appleMapsCaps = {
    Cap.buttCap: apple_maps.Cap.buttCap,
    Cap.roundCap: apple_maps.Cap.roundCap,
    Cap.squareCap: apple_maps.Cap.squareCap,
  };

  apple_maps.Cap get applePolylineCap {
    return appleMapsCaps[this]!;
  }
}

extension on JointType {
  static const List<apple_maps.JointType> appleMapsJointTypes = [
    apple_maps.JointType.mitered,
    apple_maps.JointType.bevel,
    apple_maps.JointType.round,
  ];

  apple_maps.JointType get appleMapsJointType {
    return appleMapsJointTypes[value];
  }
}

extension on List<PatternItem> {
  List<apple_maps.PatternItem> get appleMapsPatternItemList {
    return map((patternItem) => patternItem.appleMapsPatternItem).toList();
  }
}

extension on PatternItem {
  apple_maps.PatternItem get appleMapsPatternItem {
    return switch (this) {
      DotPatternItem() => apple_maps.PatternItem.dot,
      DashPatternItem dash => apple_maps.PatternItem.dash(dash.length),
      GapPatternItem gap => apple_maps.PatternItem.gap(gap.length),
    };
  }
}

extension PolygonMapper on Set<Polygon> {
  Set<apple_maps.Polygon> get appleMapsPolygonSet {
    return map((polygon) => polygon.appleMapsPolygon).toSet();
  }
}

extension on Polygon {
  apple_maps.Polygon get appleMapsPolygon {
    return apple_maps.Polygon(
      polygonId: apple_maps.PolygonId(polygonId.value),
      consumeTapEvents: consumeTapEvents,
      fillColor: fillColor,
      onTap: onTap,
      points: points.appleLatLngList,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      visible: visible,
    );
  }
}

extension CircleMapper on Set<Circle> {
  Set<apple_maps.Circle> get appleMapsCircleSet {
    return map((circle) => circle.appleMapsCircle).toSet();
  }
}

extension on Circle {
  apple_maps.Circle get appleMapsCircle {
    return apple_maps.Circle(
      circleId: apple_maps.CircleId(circleId.value),
      consumeTapEvents: consumeTapEvents,
      fillColor: fillColor,
      onTap: onTap,
      center: center.appleMapsLatLng,
      radius: radius,
      strokeColor: strokeColor,
      strokeWidth: strokeWidth,
      visible: visible,
    );
  }
}

extension ZoomMapper on MinMaxZoomPreference {
  apple_maps.MinMaxZoomPreference get appleMapsZoomPreference {
    return apple_maps.MinMaxZoomPreference(minZoom, maxZoom);
  }
}

extension AppleMapsControllerMappers on apple_maps.AppleMapController {
  PlatformMapController get platformMapController {
    return PlatformMapController(AppleMapsPlatformController(this));
  }
}
