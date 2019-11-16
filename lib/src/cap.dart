// Copyright 2019 The Chromium Authors. All rights reserved.
part of flutter_platform_maps;

enum Cap {
  buttCap,
  roundCap,
  squareCap,
}

/// Cap that can be applied at the start or end vertex of a [Polyline].
@immutable
class _Cap {
  static const Map<Cap, googleMaps.Cap> googleMapsCaps = {
    Cap.buttCap: googleMaps.Cap.buttCap,
    Cap.roundCap: googleMaps.Cap.roundCap,
    Cap.squareCap: googleMaps.Cap.squareCap,
  };

  static const Map<Cap, appleMaps.Cap> appleMapsCaps = {
    Cap.buttCap: appleMaps.Cap.buttCap,
    Cap.roundCap: appleMaps.Cap.roundCap,
    Cap.squareCap: appleMaps.Cap.squareCap,
  };

  static googleMaps.Cap googlePolylineCap(Cap cap) {
    return googleMapsCaps[cap];
  }

  static appleMaps.Cap applePolylineCap(Cap cap) {
    print('Cap: ${cap}');
    return appleMapsCaps[cap];
  }
}
