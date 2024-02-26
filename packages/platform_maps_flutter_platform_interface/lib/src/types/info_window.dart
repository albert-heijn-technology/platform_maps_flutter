import 'dart:ui';

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
