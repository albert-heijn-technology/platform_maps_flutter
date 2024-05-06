import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Verify widget generation', () {
    PlatformMapsPlatform.instance = FakePlatform();

    final widget = PlatformMapsPlatformWidget(
      const PlatformMapsPlatformWidgetCreationParams(
        initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
      ),
    );
    expect(widget, isA<FakeWidget>());
  });

  test('Verify bitmap descriptor generation', () {
    PlatformMapsPlatform.instance = FakePlatform();

    final platformBitmapDescriptor = PlatformBitmapDescriptor();
    expect(platformBitmapDescriptor, isA<FakePlatformBitmapDescriptor>());

    final bitmapDescriptor = platformBitmapDescriptor.fromBytes(Uint8List.fromList([1, 2]));
    expect(bitmapDescriptor, isA<FakeBitmapDescriptor>());
  });

  test('Verify camera update generation', () {
    PlatformMapsPlatform.instance = FakePlatform();

    final platformCameraUpdate = PlatformCameraUpdate();
    expect(platformCameraUpdate, isA<FakePlatformCameraUpdate>());

    final cameraUpdate = platformCameraUpdate.zoomIn();
    expect(cameraUpdate, isA<FakeCameraUpdate>());
  });
}

class FakePlatform extends PlatformMapsPlatform {
  @override
  PlatformMapsPlatformWidget createPlatformMapsPlatformWidget(
    PlatformMapsPlatformWidgetCreationParams params,
  ) {
    return FakeWidget(params);
  }

  @override
  PlatformBitmapDescriptor createBitmapDescriptor() => FakePlatformBitmapDescriptor();

  @override
  PlatformCameraUpdate createPlatformCameraUpdate() => FakePlatformCameraUpdate();
}

class FakeWidget extends PlatformMapsPlatformWidget {
  FakeWidget(super.params) : super.implementation();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class FakePlatformBitmapDescriptor extends PlatformBitmapDescriptor {
  FakePlatformBitmapDescriptor() : super.implementation();

  @override
  Future<BitmapDescriptor> fromAssetImage(
    ImageConfiguration configuration,
    String assetName, {
    AssetBundle? bundle,
    String? package,
  }) {
    return Future.value(FakeBitmapDescriptor());
  }

  @override
  BitmapDescriptor fromBytes(Uint8List byteData) {
    return FakeBitmapDescriptor();
  }
}

class FakeBitmapDescriptor extends BitmapDescriptor {}

class FakePlatformCameraUpdate extends PlatformCameraUpdate {
  FakePlatformCameraUpdate() : super.implementation();

  @override
  CameraUpdate zoomIn() => FakeCameraUpdate();

  @override
  CameraUpdate newCameraPosition(CameraPosition cameraPosition) {
    throw UnimplementedError();
  }

  @override
  CameraUpdate newLatLng(LatLng latLng) {
    throw UnimplementedError();
  }

  @override
  CameraUpdate newLatLngBounds(LatLngBounds bounds, double padding) {
    throw UnimplementedError();
  }

  @override
  CameraUpdate newLatLngZoom(LatLng latLng, double zoom) {
    throw UnimplementedError();
  }

  @override
  CameraUpdate zoomBy(double amount) {
    throw UnimplementedError();
  }

  @override
  CameraUpdate zoomOut() {
    throw UnimplementedError();
  }

  @override
  CameraUpdate zoomTo(double zoom) {
    throw UnimplementedError();
  }
}

class FakeCameraUpdate extends CameraUpdate {}
