// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of flutter_platform_maps;

/// The position of the map "camera", the view point from which the world is
/// shown in the map view. Aggregates the camera's [target] geographical
/// location, its [zoom] level, [pitch] angle, and [heading].
class CameraPosition
    implements googleMaps.CameraPosition, appleMaps.CameraPosition {
  const CameraPosition({
    @required this.target,
    this.heading = 0.0,
    this.pitch = 0.0,
    this.zoom = 0,
  })  : assert(target != null),
        assert(heading != null),
        assert(pitch != null),
        assert(zoom != null);

  /// The camera's bearing in degrees, measured clockwise from north.
  ///
  /// A bearing of 0.0, the default, means the camera points north.
  /// A bearing of 90.0 means the camera points east.
  final double heading;

  /// The geographical location that the camera is pointing at.
  final LatLng target;

  // In degrees where 0 is looking straight down. Pitch may be clamped to an appropriate value.
  final double pitch;

  /// The zoom level of the camera.
  ///
  /// A zoom of 0.0, the default, means the screen width of the world is 256.
  /// Adding 1.0 to the zoom level doubles the screen width of the map. So at
  /// zoom level 3.0, the screen width of the world is 2³x256=2048.
  ///
  /// Larger zoom levels thus means the camera is placed closer to the surface
  /// of the Earth, revealing more detail in a narrower geographical region.
  ///
  /// The supported zoom level range depends on the map data and device. Values
  /// beyond the supported range are allowed, but on applying them to a map they
  /// will be silently clamped to the supported range.
  final double zoom;

  @override
  String toString() =>
      'CameraPosition(bearing: $heading, target: $target, tilt: $pitch, zoom: $zoom)';

  @override
  // TODO: implement bearing
  double get bearing => null;

  @override
  // TODO: implement tilt
  double get tilt => null;

  @override
  toMap() {
    // TODO: implement toMap
    return null;
  }
}
