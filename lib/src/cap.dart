// Copyright 2019 The Chromium Authors. All rights reserved.
part of '../platform_maps_flutter.dart';

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

/// Cap that can be applied at the start or end vertex of a [Polyline].
@immutable
class _Cap {
  static const Map<Cap, google_maps.Cap> googleMapsCaps = {
    Cap.buttCap: google_maps.Cap.buttCap,
    Cap.roundCap: google_maps.Cap.roundCap,
    Cap.squareCap: google_maps.Cap.squareCap,
  };

  static const Map<Cap, apple_maps.Cap> appleMapsCaps = {
    Cap.buttCap: apple_maps.Cap.buttCap,
    Cap.roundCap: apple_maps.Cap.roundCap,
    Cap.squareCap: apple_maps.Cap.squareCap,
  };

  static google_maps.Cap googlePolylineCap(Cap cap) {
    return googleMapsCaps[cap]!;
  }

  static apple_maps.Cap applePolylineCap(Cap cap) {
    return appleMapsCaps[cap]!;
  }
}
