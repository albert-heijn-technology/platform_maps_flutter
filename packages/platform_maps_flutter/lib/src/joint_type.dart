// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

part of '../platform_maps_flutter.dart';

/// Joint types for [Polyline].
@immutable
class JointType {
  const JointType._(this.value);

  /// The value representing the [JointType] on the sdk.
  final int value;

  static const List<google_maps.JointType> googleMapsJointTypes = [
    google_maps.JointType.mitered,
    google_maps.JointType.bevel,
    google_maps.JointType.round,
  ];

  static const List<apple_maps.JointType> appleMapsJointTypes = [
    apple_maps.JointType.mitered,
    apple_maps.JointType.bevel,
    apple_maps.JointType.round,
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

  static google_maps.JointType getGoogleMapsJointType(JointType jointType) {
    return googleMapsJointTypes[jointType.value];
  }

  static apple_maps.JointType getAppleMapsJointType(JointType jointType) {
    return appleMapsJointTypes[jointType.value];
  }
}
