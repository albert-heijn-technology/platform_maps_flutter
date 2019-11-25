// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of flutter_platform_maps;

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
class MinMaxZoomPreference
    implements appleMaps.MinMaxZoomPreference, googleMaps.MinMaxZoomPreference {
  const MinMaxZoomPreference(this.minZoom, this.maxZoom)
      : assert(minZoom == null || maxZoom == null || minZoom <= maxZoom);

  static const unbounded = MinMaxZoomPreference(null, null);

  /// The preferred minimum zoom level or null, if unbounded from below.
  final double minZoom;

  /// The preferred maximum zoom level or null, if unbounded from above.
  final double maxZoom;

  appleMaps.MinMaxZoomPreference get appleMapsZoomPreference =>
      appleMaps.MinMaxZoomPreference(this.maxZoom, this.maxZoom);

  googleMaps.MinMaxZoomPreference get googleMapsZoomPreference =>
      googleMaps.MinMaxZoomPreference(this.maxZoom, this.maxZoom);
}
