// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of platform_maps_flutter;

/// Joint types for [Polyline].
@immutable
class JointType {
  const JointType._(this.value);

  /// The value representing the [JointType] on the sdk.
  final int value;

  static const List<googleMaps.JointType> googleMapsJointTypes = const [
    googleMaps.JointType.mitered,
    googleMaps.JointType.bevel,
    googleMaps.JointType.round,
  ];

  static const List<appleMaps.JointType> appleMapsJointTypes = const [
    appleMaps.JointType.mitered,
    appleMaps.JointType.bevel,
    appleMaps.JointType.round,
  ];

  /// Mitered joint, with fixed pointed extrusion equal to half the stroke width on the outside of the joint.
  ///
  /// Constant Value: 0
  static const JointType mitered = JointType._(0);

  /// Flat bevel on the outside of the joint.
  ///
  /// Constant Value: 1
  static const JointType bevel = JointType._(1);

  /// Rounded on the outside of the joint by an arc of radius equal to half the stroke width, centered at the vertex.
  ///
  /// Constant Value: 2
  static const JointType round = JointType._(2);

  static googleMaps.JointType getGoogleMapsJointType(JointType jointType) {
    return googleMapsJointTypes[jointType.value];
  }

  static appleMaps.JointType getAppleMapsJointType(JointType jointType) {
    return appleMapsJointTypes[jointType.value];
  }
}
