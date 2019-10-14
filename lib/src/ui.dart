// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of flutter_platform_maps;

/// Type of map tiles to display.
class MapType {
  static get normal {
    if (Platform.isIOS) {
      return appleMaps.MapType.standard;
    } else if (Platform.isAndroid) {
      return googleMaps.MapType.normal;
    }
  }

  static get satallite {
    if (Platform.isIOS) {
      return appleMaps.MapType.satellite;
    } else if (Platform.isAndroid) {
      return googleMaps.MapType.satellite;
    }
  }

  static get hybrid {
    if (Platform.isIOS) {
      return appleMaps.MapType.hybrid;
    } else if (Platform.isAndroid) {
      return googleMaps.MapType.hybrid;
    }
  }
}

// Used with [GoogleMapOptions] to wrap min and max zoom. This allows
// distinguishing between specifying unbounded zooming (null `minZoom` and
// `maxZoom`) from not specifying anything (null `MinMaxZoomPreference`).
class MinMaxZoomPreference
    implements appleMaps.MinMaxZoomPreference, googleMaps.MinMaxZoomPreference {
  const MinMaxZoomPreference(this.minZoom, this.maxZoom)
      : assert(minZoom == null || maxZoom == null || minZoom <= maxZoom);

  /// The preferred minimum zoom level or null, if unbounded from below.
  final double minZoom;

  /// The preferred maximum zoom level or null, if unbounded from above.
  final double maxZoom;

  /// Unbounded zooming.
  static MinMaxZoomPreference get unbounded {
    if (Platform.isIOS) {
      return appleMaps.MinMaxZoomPreference.unbounded;
    } else if (Platform.isAndroid) {
      return googleMaps.MinMaxZoomPreference.unbounded;
    }
    return null;
  }

  appleMaps.MinMaxZoomPreference get appleMapsZoomPreference =>
      appleMaps.MinMaxZoomPreference(this.maxZoom, this.maxZoom);

  googleMaps.MinMaxZoomPreference get googleMapsZoomPreference =>
      googleMaps.MinMaxZoomPreference(this.maxZoom, this.maxZoom);
}
