part of '../platform_maps_flutter.dart';

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

  static google_maps.PatternItem _googleMapsPatternItem(PatternItem patternItem) {
    if (patternItem._json[0] == 'dash') {
      return google_maps.PatternItem.dash(patternItem._json[1]);
    } else if (patternItem._json[0] == 'gap') {
      return google_maps.PatternItem.gap(patternItem._json[1]);
    }
    return google_maps.PatternItem.dot;
  }

  static apple_maps.PatternItem _appleMapsPatternItem(PatternItem patternItem) {
    if (patternItem._json[0] == 'dash') {
      return apple_maps.PatternItem.dash(patternItem._json[1]);
    } else if (patternItem._json[0] == 'gap') {
      return apple_maps.PatternItem.gap(patternItem._json[1]);
    }
    return apple_maps.PatternItem.dot;
  }

  final dynamic _json;

  static List<google_maps.PatternItem> getGoogleMapsPatternItemList(
      List<PatternItem> patternItems) {
    List<google_maps.PatternItem> googleMapsPatternItems = [];
    for (var patternItem in patternItems) {
      googleMapsPatternItems.add(
        _googleMapsPatternItem(patternItem),
      );
    }
    return googleMapsPatternItems;
  }

  static List<apple_maps.PatternItem> getAppleMapsPatternItemList(List<PatternItem> patternItems) {
    List<apple_maps.PatternItem> appleMapsPatternItems = [];
    for (var patternItem in patternItems) {
      appleMapsPatternItems.add(
        _appleMapsPatternItem(patternItem),
      );
    }
    return appleMapsPatternItems;
  }
}
