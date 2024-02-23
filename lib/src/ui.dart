// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of '../platform_maps_flutter.dart';

/// Type of map tiles to display.
enum MapType {
  /// Normal tiles (traffic and labels, subtle terrain information).
  normal,

  /// Satellite imaging tiles (aerial photos)
  satellite,

  /// Hybrid tiles (satellite images with some labels/overlays)
  hybrid,
}

// Used with [PlatformMapOptions] to wrap min and max zoom. This allows
// distinguishing between specifying unbounded zooming (null `minZoom` and
// `maxZoom`) from not specifying anything (null `MinMaxZoomPreference`).
class MinMaxZoomPreference {
  const MinMaxZoomPreference(this.minZoom, this.maxZoom)
      : assert(minZoom == null || maxZoom == null || minZoom <= maxZoom);

  static const unbounded = MinMaxZoomPreference(null, null);

  /// The preferred minimum zoom level or null, if unbounded from below.
  final double? minZoom;

  /// The preferred maximum zoom level or null, if unbounded from above.
  final double? maxZoom;

  apple_maps.MinMaxZoomPreference get appleMapsZoomPreference =>
      apple_maps.MinMaxZoomPreference(maxZoom, maxZoom);

  google_maps.MinMaxZoomPreference get googleMapsZoomPreference =>
      google_maps.MinMaxZoomPreference(maxZoom, maxZoom);

  /// Converts this object to something serializable in JSON.
  dynamic toJson() => <dynamic>[minZoom, maxZoom];
}
