import 'package:flutter/material.dart';

/// Item used in the stroke pattern for a Polyline.
@immutable
sealed class PatternItem {
  const PatternItem._();

  static const PatternItem dot = DotPatternItem();

  /// A dash used in the stroke pattern for a [Polyline].
  ///
  /// [length] has to be non-negative.
  static PatternItem dash(double length) {
    assert(length >= 0.0);
    return DashPatternItem(length);
  }

  /// A gap used in the stroke pattern for a [Polyline].
  ///
  /// [length] has to be non-negative.
  static PatternItem gap(double length) {
    assert(length >= 0.0);
    return GapPatternItem(length);
  }
}

class DotPatternItem extends PatternItem {
  const DotPatternItem() : super._();
}

class DashPatternItem extends PatternItem {
  final double length;
  const DashPatternItem(this.length) : super._();
}

class GapPatternItem extends PatternItem {
  final double length;
  const GapPatternItem(this.length) : super._();
}
