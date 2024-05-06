import 'package:flutter/material.dart';

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

  // TODO get rid of the `_json` field and migrate to sealed class
  final dynamic _json;
}
