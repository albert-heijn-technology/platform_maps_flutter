import 'package:flutter/material.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlatformMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(47.6, 8.8796),
          zoom: 16.0,
        ),
        markers: <Marker>{
          Marker(
            markerId: const MarkerId('marker_1'),
            position: const LatLng(47.6, 8.8796),
            consumeTapEvents: true,
            infoWindow: const InfoWindow(
              title: 'PlatformMarker',
              snippet: "Hi I'm a Platform Marker",
            ),
            onTap: () {
              debugPrint("Marker tapped");
            },
          ),
        },
        mapType: MapType.satellite,
        onTap: (location) => debugPrint('onTap: $location'),
        onCameraMove: (cameraUpdate) =>
            debugPrint('onCameraMove: $cameraUpdate'),
        compassEnabled: true,
        onMapCreated: (controller) {
          Future.delayed(const Duration(seconds: 2)).then(
            (_) {
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  const CameraPosition(
                    bearing: 270.0,
                    target: LatLng(51.5160895, -0.1294527),
                    tilt: 30.0,
                    zoom: 18,
                  ),
                ),
              );
              controller
                  .getVisibleRegion()
                  .then((bounds) => debugPrint("bounds: ${bounds.toString()}"));
            },
          );
        },
      ),
    );
  }
}
