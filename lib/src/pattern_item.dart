part of flutter_platform_maps;

/// Item used in the stroke pattern for a Polyline.
@immutable
class PatternItem {
  const PatternItem._(this._json);

  static const PatternItem dot = PatternItem._(<dynamic>['dot']);

  /// A dash used in the stroke pattern for a [Polyline].
  ///
  /// [length] has to be non-negative.
  static PatternItem dash(double length) {
    assert(length >= 0.0);
    return PatternItem._(<dynamic>['dash', length]);
  }

  /// A gap used in the stroke pattern for a [Polyline].
  ///
  /// [length] has to be non-negative.
  static PatternItem gap(double length) {
    assert(length >= 0.0);
    return PatternItem._(<dynamic>['gap', length]);
  }

  static googleMaps.PatternItem _googleMapsPatternItem(
      PatternItem patternItem) {
    if (patternItem._json[0] == 'dash') {
      return googleMaps.PatternItem.dash(patternItem._json[1]);
    } else if (patternItem._json[0] == 'gap') {
      return googleMaps.PatternItem.gap(patternItem._json[1]);
    }
    return googleMaps.PatternItem.dot;
  }

  static appleMaps.PatternItem _appleMapsPatternItem(PatternItem patternItem) {
    if (patternItem._json[0] == 'dash') {
      return appleMaps.PatternItem.dash(patternItem._json[1]);
    } else if (patternItem._json[0] == 'gap') {
      return appleMaps.PatternItem.gap(patternItem._json[1]);
    }
    return appleMaps.PatternItem.dot;
  }

  final dynamic _json;

  static List<googleMaps.PatternItem> getGoogleMapsPatternItemList(
      List<PatternItem> patternItems) {
    List<googleMaps.PatternItem> googleMapsPatternItems = List();
    patternItems.forEach((PatternItem patternItem) {
      googleMapsPatternItems.add(
        _googleMapsPatternItem(patternItem),
      );
    });
    return googleMapsPatternItems;
  }

  static List<appleMaps.PatternItem> getAppleMapsPatternItemList(
      List<PatternItem> patternItems) {
    List<appleMaps.PatternItem> appleMapsPatternItems = List();
    patternItems.forEach((PatternItem patternItem) {
      appleMapsPatternItems.add(
        _appleMapsPatternItem(patternItem),
      );
    });
    return appleMapsPatternItems;
  }
}
