part of '../platform_maps_flutter.dart';

/// Uniquely identifies a [Polyline] among [AppleMap] polylines.
///
/// This does not have to be globally unique, only unique among the list.
@immutable
class PolylineId {
  const PolylineId(this.value);

  /// value of the [PolylineId].
  final String value;

  google_maps.PolylineId googleMapsPolylineId() {
    return google_maps.PolylineId(
      value,
    );
  }

  apple_maps.PolylineId appleMapsPolylineId() {
    return apple_maps.PolylineId(
      value,
    );
  }
}

/// Draws a line through geographical locations on the map.
@immutable
class Polyline {
  const Polyline({
    required this.polylineId,
    this.consumeTapEvents = false,
    this.color = Colors.black,
    this.polylineCap = Cap.buttCap,
    this.jointType = JointType.mitered,
    this.points = const <LatLng>[],
    this.patterns = const <PatternItem>[],
    this.visible = true,
    this.width = 10,
    this.zIndex = 0,
    this.onTap,
  });

  /// Uniquely identifies a [Polyline].
  final PolylineId polylineId;

  /// True if the [Polyline] consumes tap events.
  ///
  /// If this is false, [onTap] callback will not be triggered.
  final bool consumeTapEvents;

  /// Line segment color in ARGB format, the same format used by Color. The default value is black (0xff000000).
  final Color color;

  /// Indicates whether the segments of the polyline should be drawn as geodesics, as opposed to straight lines
  /// on the Mercator projection.
  ///
  /// A geodesic is the shortest path between two points on the Earth's surface.
  /// The geodesic curve is constructed assuming the Earth is a sphere
  // final bool geodesic;

  /// Joint type of the polyline line segments.
  ///
  /// The joint type defines the shape to be used when joining adjacent line segments at all vertices of the
  /// polyline except the start and end vertices. See [JointType] for supported joint types. The default value is
  /// mitered.
  ///
  /// Supported on Android only.
  final JointType jointType;

  /// The stroke pattern for the polyline.
  ///
  /// Solid or a sequence of PatternItem objects to be repeated along the line.
  /// Available PatternItem types: Gap (defined by gap length in pixels), Dash (defined by line width and dash
  /// length in pixels) and Dot (circular, centered on the line, diameter defined by line width in pixels).
  ///
  /// Note: It is not possible to have a mix of dots and dashes.
  final List<PatternItem> patterns;

  /// The vertices of the polyline to be drawn.
  ///
  /// Line segments are drawn between consecutive points. A polyline is not closed by
  /// default; to form a closed polyline, the start and end points must be the same.
  final List<LatLng> points;

  /// The cap at the end vertex of the polyline.
  ///
  /// The default end cap is ButtCap.
  final Cap polylineCap;

  /// True if the marker is visible.
  final bool visible;

  /// Width of the polyline, used to define the width of the line segment to be drawn.
  ///
  /// The width is constant and independent of the camera's zoom level.
  /// The default value is 10.
  final int width;

  /// The z-index of the polyline, used to determine relative drawing order of
  /// map overlays.
  ///
  /// Overlays are drawn in order of z-index, so that lower values means drawn
  /// earlier, and thus appearing to be closer to the surface of the Earth.
  final int zIndex;

  /// Callbacks to receive tap events for polyline placed on this map.
  final VoidCallback? onTap;

  static Set<google_maps.Polyline> toGoogleMapsPolylines(Set<Polyline> polylines) {
    Set<google_maps.Polyline> googleMapsPolylines = {};
    for (var polyline in polylines) {
      googleMapsPolylines.add(
        google_maps.Polyline(
          polylineId: polyline.polylineId.googleMapsPolylineId(),
          color: polyline.color,
          consumeTapEvents: polyline.consumeTapEvents,
          endCap: _Cap.googlePolylineCap(polyline.polylineCap),
          jointType: JointType.getGoogleMapsJointType(polyline.jointType),
          onTap: polyline.onTap,
          patterns: PatternItem.getGoogleMapsPatternItemList(polyline.patterns),
          points: LatLng.googleMapsLatLngsFromList(polyline.points),
          startCap: _Cap.googlePolylineCap(polyline.polylineCap),
          visible: polyline.visible,
          width: polyline.width,
        ),
      );
    }
    return googleMapsPolylines;
  }

  static Set<apple_maps.Polyline> toAppleMapsPolylines(Set<Polyline> polylines) {
    Set<apple_maps.Polyline> appleMapsPolylines = {};
    for (var polyline in polylines) {
      appleMapsPolylines.add(
        apple_maps.Polyline(
          polylineId: polyline.polylineId.appleMapsPolylineId(),
          color: polyline.color,
          consumeTapEvents: polyline.consumeTapEvents,
          polylineCap: _Cap.applePolylineCap(polyline.polylineCap),
          jointType: JointType.getAppleMapsJointType(polyline.jointType),
          onTap: polyline.onTap,
          patterns: PatternItem.getAppleMapsPatternItemList(polyline.patterns),
          points: LatLng.appleMapsLatLngsFromList(polyline.points),
          visible: polyline.visible,
          width: polyline.width,
        ),
      );
    }
    return appleMapsPolylines;
  }

  Polyline copyWith({
    Color? colorParam,
    bool? consumeTapEventsParam,
    Cap? polylineCapParam,
    JointType? jointTypeParam,
    List<PatternItem>? patternsParam,
    List<LatLng>? pointsParam,
    bool? visibleParam,
    int? widthParam,
    int? zIndexParam,
    VoidCallback? onTapParam,
  }) {
    return Polyline(
      polylineId: polylineId,
      color: colorParam ?? color,
      consumeTapEvents: consumeTapEventsParam ?? consumeTapEvents,
      polylineCap: polylineCapParam ?? polylineCap,
      jointType: jointTypeParam ?? jointType,
      patterns: patternsParam ?? patterns,
      points: pointsParam ?? points,
      visible: visibleParam ?? visible,
      width: widthParam ?? width,
      onTap: onTapParam ?? onTap,
      zIndex: zIndexParam ?? zIndex,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Polyline) return false;
    final Polyline typedOther = other;
    return polylineId == typedOther.polylineId;
  }

  @override
  int get hashCode => polylineId.hashCode;
}
