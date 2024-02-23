// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of '../platform_maps_flutter.dart';

/// Uniquely identifies a [Circle] among [PlatformMap] circles.
///
/// This does not have to be globally unique, only unique among the list.
@immutable
class CircleId {
  /// Creates an immutable identifier for a [Circle].
  const CircleId(this.value);

  /// value of the [CircleId].
  final String value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CircleId) return false;
    final CircleId typedOther = other;
    return value == typedOther.value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'CircleId{value: $value}';
  }
}

/// Draws a circle on the map.
@immutable
class Circle {
  /// Creates an immutable representation of a [Circle] to draw on [PlatformMap].
  const Circle({
    required this.circleId,
    this.consumeTapEvents = false,
    this.fillColor = Colors.transparent,
    this.center = const LatLng(0.0, 0.0),
    this.radius = 0,
    this.strokeColor = Colors.black,
    this.strokeWidth = 10,
    this.visible = true,
    this.onTap,
  });

  /// Uniquely identifies a [Circle].
  final CircleId circleId;

  /// True if the [Circle] consumes tap events.
  ///
  /// If this is false, [onTap] callback will not be triggered.
  final bool consumeTapEvents;

  /// Fill color in ARGB format, the same format used by Color. The default value is transparent (0x00000000).
  final Color fillColor;

  /// Geographical location of the circle center.
  final LatLng center;

  /// Radius of the circle in meters; must be positive. The default value is 0.
  final double radius;

  /// Fill color in ARGB format, the same format used by Color. The default value is black (0xff000000).
  final Color strokeColor;

  /// The width of the circle's outline in screen points.
  ///
  /// The width is constant and independent of the camera's zoom level.
  /// The default value is 10.
  /// Setting strokeWidth to 0 results in no stroke.
  final int strokeWidth;

  /// True if the circle is visible.
  final bool visible;

  /// Callbacks to receive tap events for circle placed on this map.
  final VoidCallback? onTap;

  /// Creates a new [Circle] object whose values are the same as this instance,
  /// unless overwritten by the specified parameters.
  Circle copyWith({
    bool? consumeTapEventsParam,
    Color? fillColorParam,
    LatLng? centerParam,
    double? radiusParam,
    Color? strokeColorParam,
    int? strokeWidthParam,
    bool? visibleParam,
    VoidCallback? onTapParam,
  }) {
    return Circle(
      circleId: circleId,
      consumeTapEvents: consumeTapEventsParam ?? consumeTapEvents,
      fillColor: fillColorParam ?? fillColor,
      center: centerParam ?? center,
      radius: radiusParam ?? radius,
      strokeColor: strokeColorParam ?? strokeColor,
      strokeWidth: strokeWidthParam ?? strokeWidth,
      visible: visibleParam ?? visible,
      onTap: onTapParam ?? onTap,
    );
  }

  /// Creates a new [Circle] object whose values are the same as this instance.
  Circle clone() => copyWith();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Circle) return false;
    final Circle typedOther = other;
    return circleId == typedOther.circleId &&
        consumeTapEvents == typedOther.consumeTapEvents &&
        fillColor == typedOther.fillColor &&
        center == typedOther.center &&
        radius == typedOther.radius &&
        strokeColor == typedOther.strokeColor &&
        strokeWidth == typedOther.strokeWidth &&
        visible == typedOther.visible &&
        onTap == typedOther.onTap;
  }

  static Set<google_maps.Circle> toGoogleMapsCircleSet(Set<Circle> circles) {
    List<google_maps.Circle> circles0 = <google_maps.Circle>[];
    for (Circle circle in circles) {
      circles0.add(circle.googleMapsCircle);
    }
    return Set.from(circles0);
  }

  static Set<apple_maps.Circle> toAppleMapsCircleSet(Set<Circle> circles) {
    List<apple_maps.Circle> circles0 = <apple_maps.Circle>[];
    for (Circle circle in circles) {
      circles0.add(circle.appleMapsCircle);
    }
    return Set.from(circles0);
  }

  google_maps.Circle get googleMapsCircle => google_maps.Circle(
        circleId: google_maps.CircleId(circleId.value),
        consumeTapEvents: consumeTapEvents,
        fillColor: fillColor,
        onTap: onTap,
        center: center.googleLatLng,
        radius: radius,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        visible: visible,
      );

  apple_maps.Circle get appleMapsCircle => apple_maps.Circle(
        circleId: apple_maps.CircleId(circleId.value),
        consumeTapEvents: consumeTapEvents,
        fillColor: fillColor,
        onTap: onTap,
        center: center.appleLatLng,
        radius: radius,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        visible: visible,
      );

  @override
  int get hashCode => circleId.hashCode;
}
