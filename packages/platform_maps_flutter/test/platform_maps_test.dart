import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart';

void main() {
  testWidgets('Load platform widget', (tester) async {
    PlatformMapsPlatform.instance = FakePlatform();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlatformMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(4.4, 5.5),
            ),
          ),
        ),
      ),
    );

    expect(find.text('4.4,5.5'), findsOneWidget);
  });
}

class FakePlatform extends PlatformMapsPlatform {
  @override
  PlatformMapsPlatformWidget createPlatformMapsPlatformWidget(
    PlatformMapsPlatformWidgetCreationParams params,
  ) {
    return FakeWidget(params);
  }
}

class FakeWidget extends PlatformMapsPlatformWidget {
  FakeWidget(super.params) : super.implementation();

  @override
  Widget build(BuildContext context) {
    final target = params.initialCameraPosition.target;
    return Center(child: Text('${target.latitude},${target.longitude}'));
  }
}
