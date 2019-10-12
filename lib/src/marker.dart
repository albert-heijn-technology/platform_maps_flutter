// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of flutter_platform_maps;

dynamic _offsetToJson(Offset offset) {
  if (offset == null) {
    return null;
  }
  return <dynamic>[offset.dx, offset.dy];
}

/// Text labels for a [Marker] info window.
class InfoWindow {
  const InfoWindow({
    this.title,
    this.snippet,
    this.onTap,
  });

  /// Text labels specifying that no text is to be displayed.
  static const InfoWindow noText = InfoWindow();

  /// Text displayed in an info window when the user taps the marker.
  ///
  /// A null value means no title.
  final String title;

  /// Additional text displayed below the [title].
  ///
  /// A null value means no additional text.
  final String snippet;

  /// onTap callback for this [InfoWindow].
  final VoidCallback onTap;

  appleMaps.InfoWindow get appleMapsInfoWindow => appleMaps.InfoWindow(
        anchor: Offset(0, 0),
        onTap: this.onTap,
        snippet: this.snippet,
        title: this.title,
      );

  googleMaps.InfoWindow get googleMapsInfoWindow => googleMaps.InfoWindow(
        anchor: Offset(0, 0),
        onTap: this.onTap,
        snippet: this.snippet,
        title: this.title,
      );
}

/// Uniquely identifies a [Marker] among [GoogleMap] markers.
///
/// This does not have to be globally unique, only unique among the list.
@immutable
class MarkerId {
  MarkerId(this.value) : assert(value != null);

  /// value of the [MarkerId].
  final String value;

  appleMaps.AnnotationId get appleMapsAnnoationId => appleMaps.AnnotationId(
        this.value,
      );

  googleMaps.MarkerId get googleMapsMarkerId => googleMaps.MarkerId(
        this.value,
      );
}

/// Marks a geographical location on the map.
///
/// A marker icon is drawn oriented against the device's screen rather than
/// the map's surface; that is, it will not necessarily change orientation
/// due to map rotations, tilting, or zooming.
@immutable
class Marker {
  /// Creates a set of marker configuration options.
  ///
  /// Default marker options.
  ///
  /// Specifies a marker that
  /// * is fully opaque; [alpha] is 1.0
  /// * uses icon bottom center to indicate map position; [anchor] is (0.5, 1.0)
  /// * has default tap handling; [consumeTapEvents] is false
  /// * is stationary; [draggable] is false
  /// * is drawn against the screen, not the map; [flat] is false
  /// * has a default icon; [icon] is `BitmapDescriptor.defaultMarker`
  /// * anchors the info window at top center; [infoWindowAnchor] is (0.5, 0.0)
  /// * has no info window text; [infoWindowText] is `InfoWindowText.noText`
  /// * is positioned at 0, 0; [position] is `LatLng(0.0, 0.0)`
  /// * has an axis-aligned icon; [rotation] is 0.0
  /// * is visible; [visible] is true
  /// * is placed at the base of the drawing order; [zIndex] is 0.0
  const Marker({
    @required this.markerId,
    this.alpha = 1.0,
    this.consumeTapEvents = false,
    this.draggable = false,
    // this.icon = BitmapDescriptor.defaultMarker,
    this.infoWindow = InfoWindow.noText,
    this.position = const LatLng(0.0, 0.0),
    this.onTap,
  }) : assert(alpha == null || (0.0 <= alpha && alpha <= 1.0));

  /// Uniquely identifies a [Marker].
  final MarkerId markerId;

  /// The opacity of the marker, between 0.0 and 1.0 inclusive.
  ///
  /// 0.0 means fully transparent, 1.0 means fully opaque.
  final double alpha;

  /// True if the marker icon consumes tap events. If not, the map will perform
  /// default tap handling by centering the map on the marker and displaying its
  /// info window.
  final bool consumeTapEvents;

  /// True if the marker is draggable by user touch events.
  final bool draggable;

  /// A description of the bitmap used to draw the marker icon.
  // final BitmapDescriptor icon;

  /// A Google Maps InfoWindow.
  ///
  /// The window is displayed when the marker is tapped.
  final InfoWindow infoWindow;

  /// Geographical location of the marker.
  final LatLng position;

  /// Callbacks to receive tap events for markers placed on this map.
  final VoidCallback onTap;

  appleMaps.Annotation get appleMapsAnnotation => appleMaps.Annotation(
        annotationId: this.markerId.appleMapsAnnoationId,
        alpha: this.alpha,
        draggable: this.draggable,
        infoWindow: this.infoWindow.appleMapsInfoWindow,
        onTap: this.onTap,
        position: this.position.appleLatLng,
      );
}
