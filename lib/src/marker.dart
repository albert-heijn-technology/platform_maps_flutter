part of platform_maps_flutter;

/// Text labels for a [Marker] info window.
class InfoWindow {
  const InfoWindow({this.title, this.snippet, this.onTap, this.anchor});

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

  /// The icon image point that will be the anchor of the info window when
  /// displayed.
  ///
  /// The image point is specified in normalized coordinates: An anchor of
  /// (0.0, 0.0) means the top left corner of the image. An anchor
  /// of (1.0, 1.0) means the bottom right corner of the image.
  final Offset anchor;

  /// onTap callback for this [InfoWindow].
  final VoidCallback onTap;

  appleMaps.InfoWindow get appleMapsInfoWindow => appleMaps.InfoWindow(
        anchor: this.anchor ?? Offset(0, 0),
        onTap: this.onTap,
        snippet: this.snippet,
        title: this.title,
      );

  googleMaps.InfoWindow get googleMapsInfoWindow => googleMaps.InfoWindow(
        anchor: this.anchor ?? Offset(0, 0),
        onTap: this.onTap,
        snippet: this.snippet,
        title: this.title,
      );

  /// Creates a new [InfoWindow] object whose values are the same as this instance,
  /// unless overwritten by the specified parameters.
  InfoWindow copyWith({
    String titleParam,
    String snippetParam,
    Offset anchorParam,
    VoidCallback onTapParam,
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
  /// * has default tap handling; [consumeTapEvents] is false
  /// * is stationary; [draggable] is false
  /// * has a default icon; [icon] is `BitmapDescriptor.defaultMarker`
  /// * has no info window text; [infoWindowText] is `InfoWindowText.noText`
  /// * is positioned at 0, 0; [position] is `LatLng(0.0, 0.0)`
  /// * is visible; [visible] is true
  /// * is placed at the base of the drawing order; [zIndex] is 0.0
  const Marker({
    @required this.markerId,
    this.alpha = 1.0,
    this.consumeTapEvents = false,
    this.draggable = false,
    this.icon,
    this.infoWindow = InfoWindow.noText,
    this.position = const LatLng(0.0, 0.0),
    this.onTap,
    this.visible = true,
    this.onDragEnd,
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
  final BitmapDescriptor icon;

  /// A Google Maps InfoWindow.
  ///
  /// The window is displayed when the marker is tapped.
  final InfoWindow infoWindow;

  /// Geographical location of the marker.
  final LatLng position;

  /// Callbacks to receive tap events for markers placed on this map.
  final VoidCallback onTap;

  /// True if the annotation is visible.
  final bool visible;

  final ValueChanged<LatLng> onDragEnd;

  appleMaps.Annotation get appleMapsAnnotation => appleMaps.Annotation(
        annotationId: this.markerId.appleMapsAnnoationId,
        alpha: this.alpha,
        draggable: this.draggable,
        infoWindow: this.infoWindow.appleMapsInfoWindow,
        onTap: this.onTap,
        icon: this.icon.bitmapDescriptor ??
            BitmapDescriptor.defaultMarker.bitmapDescriptor,
        visible: this.visible,
        onDragEnd: this.onDragEnd != null
            ? (appleMaps.LatLng latLng) =>
                _onAppleAnnotationDragEnd(latLng, this.onDragEnd)
            : null,
        position: this.position.appleLatLng,
      );

  googleMaps.Marker get googleMapsMarker => googleMaps.Marker(
        markerId: this.markerId.googleMapsMarkerId,
        alpha: this.alpha,
        draggable: this.draggable,
        infoWindow: this.infoWindow.googleMapsInfoWindow,
        onTap: this.onTap,
        icon: this.icon.bitmapDescriptor ??
            BitmapDescriptor.defaultMarker.bitmapDescriptor,
        visible: this.visible,
        onDragEnd: this.onDragEnd != null
            ? (googleMaps.LatLng latLng) =>
                _onGoogleMarkerDragEnd(latLng, this.onDragEnd)
            : null,
        position: this.position.googleLatLng,
      );

  static appleMaps.Annotation appleMapsAnnotationFromMarker(Marker marker) =>
      appleMaps.Annotation(
        annotationId: marker.markerId.appleMapsAnnoationId,
        alpha: marker.alpha,
        anchor: Offset(0.5, 1.0),
        draggable: marker.draggable,
        infoWindow: marker.infoWindow.appleMapsInfoWindow,
        onTap: marker.onTap,
        icon: marker.icon?.bitmapDescriptor ??
            BitmapDescriptor.defaultMarker.bitmapDescriptor,
        visible: marker.visible,
        onDragEnd: marker.onDragEnd != null
            ? (appleMaps.LatLng latLng) =>
                _onAppleAnnotationDragEnd(latLng, marker.onDragEnd)
            : null,
        position: marker.position.appleLatLng,
      );

  static googleMaps.Marker googleMapsMarkerFromMarker(Marker marker) =>
      googleMaps.Marker(
        markerId: marker.markerId.googleMapsMarkerId,
        alpha: marker.alpha,
        anchor: Offset(0.5, 1.0),
        draggable: marker.draggable,
        infoWindow: marker.infoWindow.googleMapsInfoWindow,
        onTap: marker.onTap,
        icon: marker.icon?.bitmapDescriptor ??
            BitmapDescriptor.defaultMarker.bitmapDescriptor,
        visible: marker.visible,
        onDragEnd: marker.onDragEnd != null
            ? (googleMaps.LatLng latLng) =>
                _onGoogleMarkerDragEnd(latLng, marker.onDragEnd)
            : null,
        position: marker.position.googleLatLng,
      );

  static Set<appleMaps.Annotation> toAppleMapsAnnotationSet(
      Set<Marker> markers) {
    List<appleMaps.Annotation> _annotations = List<appleMaps.Annotation>();
    for (Marker marker in markers) {
      _annotations.add(appleMapsAnnotationFromMarker(marker));
    }
    return Set.from(_annotations);
  }

  static Set<googleMaps.Marker> toGoogleMapsMarkerSet(Set<Marker> markers) {
    List<googleMaps.Marker> _markers = List<googleMaps.Marker>();
    for (Marker marker in markers) {
      _markers.add(googleMapsMarkerFromMarker(marker));
    }
    return Set.from(_markers);
  }

  Marker copyWith({
    double alphaParam,
    bool consumeTapEventsParam,
    bool draggableParam,
    BitmapDescriptor iconParam,
    InfoWindow infoWindowParam,
    LatLng positionParam,
    bool visibleParam,
    VoidCallback onTapParam,
  }) {
    return Marker(
      markerId: markerId,
      alpha: alphaParam ?? alpha,
      consumeTapEvents: consumeTapEventsParam ?? consumeTapEvents,
      draggable: draggableParam ?? draggable,
      icon: iconParam ?? icon,
      infoWindow: infoWindowParam ?? infoWindow,
      position: positionParam ?? position,
      visible: visibleParam ?? visible,
      onTap: onTapParam ?? onTap,
    );
  }

  static _onGoogleMarkerDragEnd(googleMaps.LatLng latLng, Function onDragEnd) {
    if (onDragEnd != null) {
      onDragEnd(LatLng._fromGoogleLatLng(latLng));
    }
  }

  static _onAppleAnnotationDragEnd(
      appleMaps.LatLng latLng, Function onDragEnd) {
    if (onDragEnd != null) {
      onDragEnd(LatLng._fromAppleLatLng(latLng));
    }
  }
}
