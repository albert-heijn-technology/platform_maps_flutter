part of '../platform_maps_flutter.dart';

/// Text labels for a [Marker] info window.
class InfoWindow {
  const InfoWindow({this.title, this.snippet, this.onTap, this.anchor});

  /// Text labels specifying that no text is to be displayed.
  static const InfoWindow noText = InfoWindow();

  /// Text displayed in an info window when the user taps the marker.
  ///
  /// A null value means no title.
  final String? title;

  /// Additional text displayed below the [title].
  ///
  /// A null value means no additional text.
  final String? snippet;

  /// The icon image point that will be the anchor of the info window when
  /// displayed.
  ///
  /// The image point is specified in normalized coordinates: An anchor of
  /// (0.0, 0.0) means the top left corner of the image. An anchor
  /// of (1.0, 1.0) means the bottom right corner of the image.
  final Offset? anchor;

  /// onTap callback for this [InfoWindow].
  final VoidCallback? onTap;

  apple_maps.InfoWindow get appleMapsInfoWindow => apple_maps.InfoWindow(
        anchor: anchor ?? const Offset(0, 0),
        onTap: onTap,
        snippet: snippet,
        title: title,
      );

  google_maps.InfoWindow get googleMapsInfoWindow => google_maps.InfoWindow(
        anchor: anchor ?? const Offset(0, 0),
        onTap: onTap,
        snippet: snippet,
        title: title,
      );

  /// Creates a new [InfoWindow] object whose values are the same as this instance,
  /// unless overwritten by the specified parameters.
  InfoWindow copyWith({
    String? titleParam,
    String? snippetParam,
    Offset? anchorParam,
    VoidCallback? onTapParam,
  }) {
    return InfoWindow(
      title: titleParam ?? title,
      snippet: snippetParam ?? snippet,
      anchor: anchorParam ?? anchor,
      onTap: onTapParam ?? onTap,
    );
  }
}

/// Uniquely identifies a [Marker] among [PlatformMaps] markers.
///
/// This does not have to be globally unique, only unique among the list.
@immutable
class MarkerId {
  const MarkerId(this.value);

  /// value of the [MarkerId].
  final String value;

  apple_maps.AnnotationId get appleMapsAnnoationId => apple_maps.AnnotationId(
        value,
      );

  google_maps.MarkerId get googleMapsMarkerId => google_maps.MarkerId(
        value,
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
  /// * has default tap handling; [consumeTapEvents] is false
  /// * is stationary; [draggable] is false
  /// * has a default icon; [icon] is `BitmapDescriptor.defaultMarker`
  /// * has no info window text; [infoWindowText] is `InfoWindowText.noText`
  /// * is positioned at 0, 0; [position] is `LatLng(0.0, 0.0)`
  /// * is visible; [visible] is true
  /// * is placed at the base of the drawing order; [zIndex] is 0.0
  const Marker({
    required this.markerId,
    this.alpha = 1.0,
    this.anchor = const Offset(0.5, 1.0),
    this.consumeTapEvents = false,
    this.draggable = false,
    this.icon,
    this.infoWindow = InfoWindow.noText,
    this.position = const LatLng(0.0, 0.0),
    this.onTap,
    this.visible = true,
    this.onDragEnd,
  }) : assert((0.0 <= alpha && alpha <= 1.0));

  /// Uniquely identifies a [Marker].
  final MarkerId markerId;

  /// The opacity of the marker, between 0.0 and 1.0 inclusive.
  ///
  /// 0.0 means fully transparent, 1.0 means fully opaque.
  final double alpha;

  /// The icon image point that will be placed at the [position] of the marker.
  ///
  /// The image point is specified in normalized coordinates: An anchor of
  /// (0.0, 0.0) means the top left corner of the image. An anchor
  /// of (1.0, 1.0) means the bottom right corner of the image.
  final Offset anchor;

  /// True if the marker icon consumes tap events. If not, the map will perform
  /// default tap handling by centering the map on the marker and displaying its
  /// info window.
  final bool consumeTapEvents;

  /// True if the marker is draggable by user touch events.
  final bool draggable;

  /// A description of the bitmap used to draw the marker icon.
  final BitmapDescriptor? icon;

  /// A Google Maps InfoWindow.
  ///
  /// The window is displayed when the marker is tapped.
  final InfoWindow infoWindow;

  /// Geographical location of the marker.
  final LatLng position;

  /// Callbacks to receive tap events for markers placed on this map.
  final VoidCallback? onTap;

  /// True if the annotation is visible.
  final bool visible;

  final ValueChanged<LatLng>? onDragEnd;

  apple_maps.Annotation get appleMapsAnnotation => apple_maps.Annotation(
        annotationId: markerId.appleMapsAnnoationId,
        alpha: alpha,
        anchor: anchor,
        draggable: draggable,
        infoWindow: infoWindow.appleMapsInfoWindow,
        onTap: onTap,
        icon: icon?.bitmapDescriptor ?? BitmapDescriptor.defaultMarker?.bitmapDescriptor,
        visible: visible,
        onDragEnd: onDragEnd != null
            ? (apple_maps.LatLng latLng) => _onAppleAnnotationDragEnd(latLng, onDragEnd)
            : null,
        position: position.appleLatLng,
      );

  google_maps.Marker get googleMapsMarker => google_maps.Marker(
        markerId: markerId.googleMapsMarkerId,
        alpha: alpha,
        anchor: anchor,
        draggable: draggable,
        infoWindow: infoWindow.googleMapsInfoWindow,
        onTap: onTap,
        icon: icon?.bitmapDescriptor ?? BitmapDescriptor.defaultMarker?.bitmapDescriptor,
        visible: visible,
        onDragEnd: onDragEnd != null
            ? (google_maps.LatLng latLng) => _onGoogleMarkerDragEnd(latLng, onDragEnd)
            : null,
        position: position.googleLatLng,
      );

  static apple_maps.Annotation appleMapsAnnotationFromMarker(Marker marker) =>
      apple_maps.Annotation(
        annotationId: marker.markerId.appleMapsAnnoationId,
        alpha: marker.alpha,
        anchor: marker.anchor,
        draggable: marker.draggable,
        infoWindow: marker.infoWindow.appleMapsInfoWindow,
        onTap: marker.onTap,
        icon: marker.icon?.bitmapDescriptor ?? BitmapDescriptor.defaultMarker?.bitmapDescriptor,
        visible: marker.visible,
        onDragEnd: marker.onDragEnd != null
            ? (apple_maps.LatLng latLng) => _onAppleAnnotationDragEnd(latLng, marker.onDragEnd)
            : null,
        position: marker.position.appleLatLng,
      );

  static google_maps.Marker googleMapsMarkerFromMarker(Marker marker) => google_maps.Marker(
        markerId: marker.markerId.googleMapsMarkerId,
        alpha: marker.alpha,
        anchor: marker.anchor,
        draggable: marker.draggable,
        infoWindow: marker.infoWindow.googleMapsInfoWindow,
        onTap: marker.onTap,
        icon: marker.icon?.bitmapDescriptor ?? BitmapDescriptor.defaultMarker?.bitmapDescriptor,
        visible: marker.visible,
        onDragEnd: marker.onDragEnd != null
            ? (google_maps.LatLng latLng) => _onGoogleMarkerDragEnd(latLng, marker.onDragEnd)
            : null,
        position: marker.position.googleLatLng,
      );

  static Set<apple_maps.Annotation> toAppleMapsAnnotationSet(Set<Marker> markers) {
    List<apple_maps.Annotation> annotations = <apple_maps.Annotation>[];
    for (Marker marker in markers) {
      annotations.add(appleMapsAnnotationFromMarker(marker));
    }
    return Set.from(annotations);
  }

  static Set<google_maps.Marker> toGoogleMapsMarkerSet(Set<Marker> markers) {
    List<google_maps.Marker> markers0 = <google_maps.Marker>[];
    for (Marker marker in markers) {
      markers0.add(googleMapsMarkerFromMarker(marker));
    }
    return Set.from(markers0);
  }

  Marker copyWith({
    double? alphaParam,
    Offset? anchorParam,
    bool? consumeTapEventsParam,
    bool? draggableParam,
    BitmapDescriptor? iconParam,
    InfoWindow? infoWindowParam,
    LatLng? positionParam,
    bool? visibleParam,
    VoidCallback? onTapParam,
  }) {
    return Marker(
      markerId: markerId,
      alpha: alphaParam ?? alpha,
      anchor: anchorParam ?? anchor,
      consumeTapEvents: consumeTapEventsParam ?? consumeTapEvents,
      draggable: draggableParam ?? draggable,
      icon: iconParam ?? icon,
      infoWindow: infoWindowParam ?? infoWindow,
      position: positionParam ?? position,
      visible: visibleParam ?? visible,
      onTap: onTapParam ?? onTap,
    );
  }

  static _onGoogleMarkerDragEnd(google_maps.LatLng latLng, Function? onDragEnd) {
    onDragEnd?.call(LatLng._fromGoogleLatLng(latLng));
  }

  static _onAppleAnnotationDragEnd(apple_maps.LatLng latLng, Function? onDragEnd) {
    onDragEnd?.call(LatLng._fromAppleLatLng(latLng));
  }
}
