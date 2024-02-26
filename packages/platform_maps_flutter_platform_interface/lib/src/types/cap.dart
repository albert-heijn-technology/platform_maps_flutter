// Copyright 2019 The Chromium Authors. All rights reserved.

enum Cap {
  /// Cap that is squared off exactly at the start or end vertex of a [Polyline] with solid stroke pattern,
  ///  equivalent to having no additional cap beyond the start or end vertex.
  ///
  /// This is the default cap type at start and end vertices of Polylines with solid stroke pattern.
  buttCap,

  /// Cap that is a semicircle with radius equal to half the stroke width, centered at
  /// the start or end vertex of a [Polyline] with solid stroke pattern.
  roundCap,

  /// Cap that is squared off after extending half the stroke width beyond the start
  /// or end vertex of a [Polyline] with solid stroke pattern.
  squareCap,
}
