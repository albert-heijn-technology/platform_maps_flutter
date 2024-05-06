// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform_maps_flutter_platform_interface/src/types.dart';

/// Uniquely identifies a [Polygon] among [PlatformMap] polygons.
///
/// This does not have to be globally unique, only unique among the list.
@immutable
class PolygonId {
  /// Creates an immutable identifier for a [Polygon].
  const PolygonId(this.value);

  /// value of the [PolygonId].
  final String value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PolygonId) return false;
    final PolygonId typedOther = other;
    return value == typedOther.value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'PolygonId{value: $value}';
  }
}

/// Draws a polygon through geographical locations on the map.
@immutable
class Polygon {
  /// Creates an immutable representation of a polygon through geographical locations on the map.
  const Polygon({
    required this.polygonId,
    this.consumeTapEvents = false,
    this.fillColor = Colors.black,
    this.points = const <LatLng>[],
    this.strokeColor = Colors.black,
    this.strokeWidth = 10,
    this.visible = true,
    this.onTap,
  });

  /// Uniquely identifies a [Polygon].
  final PolygonId polygonId;

  /// True if the [Polygon] consumes tap events.
  ///
  /// If this is false, [onTap] callback will not be triggered.
  final bool consumeTapEvents;

  /// Fill color in ARGB format, the same format used by Color. The default value is black (0xff000000).
  final Color fillColor;

  /// The vertices of the polygon to be drawn.
  ///
  /// Line segments are drawn between consecutive points. A polygon is not closed by
  /// default; to form a closed polygon, the start and end points must be the same.
  final List<LatLng> points;

  /// True if the marker is visible.
  final bool visible;

  /// Line color in ARGB format, the same format used by Color. The default value is black (0xff000000).
  final Color strokeColor;

  /// Width of the polygon, used to define the width of the line to be drawn.
  ///
  /// The width is constant and independent of the camera's zoom level.
  /// The default value is 10.
  final int strokeWidth;

  /// Callbacks to receive tap events for polygon placed on this map.
  final VoidCallback? onTap;

  /// Creates a new [Polygon] object whose values are the same as this instance,
  /// unless overwritten by the specified parameters.
  Polygon copyWith({
    bool? consumeTapEventsParam,
    List<LatLng>? pointsParam,
    Color? strokeColorParam,
    Color? fillColorParam,
    int? strokeWidthParam,
    bool? visibleParam,
    VoidCallback? onTapParam,
  }) {
    return Polygon(
      polygonId: polygonId,
      consumeTapEvents: consumeTapEventsParam ?? consumeTapEvents,
      points: pointsParam ?? points,
      strokeColor: strokeColorParam ?? strokeColor,
      fillColor: fillColorParam ?? fillColor,
      strokeWidth: strokeWidthParam ?? strokeWidth,
      visible: visibleParam ?? visible,
      onTap: onTapParam ?? onTap,
    );
  }

  /// Creates a new [Polygon] object whose values are the same as this instance.
  Polygon clone() {
    return copyWith(pointsParam: List<LatLng>.of(points));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Polygon) return false;
    final Polygon typedOther = other;
    return polygonId == typedOther.polygonId &&
        consumeTapEvents == typedOther.consumeTapEvents &&
        fillColor == typedOther.fillColor &&
        listEquals(points, typedOther.points) &&
        visible == typedOther.visible &&
        strokeColor == typedOther.strokeColor &&
        strokeWidth == typedOther.strokeWidth &&
        onTap == typedOther.onTap;
  }

  @override
  int get hashCode => polygonId.hashCode;
}
