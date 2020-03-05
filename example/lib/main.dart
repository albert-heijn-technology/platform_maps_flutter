import 'package:flutter/material.dart';

import 'package:platform_maps_flutter/platform_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 300,
        height: 300,
        child: PlatformMap(
          initialCameraPosition: CameraPosition(
            target: const LatLng(47.6, 8.8796),
            zoom: 16.0,
          ),
          markers: Set<Marker>.of(
            [
              Marker(
                markerId: MarkerId('marker_1'),
                position: LatLng(47.6, 8.8796),
                consumeTapEvents: true,
                infoWindow: InfoWindow(
                  title: 'PlatformMarker',
                  snippet: "Hi I'm a Platform Marker",
                ),
                onTap: () {
                  print("Marker tapped");
                },
              ),
            ],
          ),
          mapType: MapType.satellite,
          onTap: (location) => print('onTap: $location'),
          onCameraMove: (cameraUpdate) => print('onCameraMove: $cameraUpdate'),
          compassEnabled: true,
          onMapCreated: (controller) {
            Future.delayed(Duration(seconds: 2)).then(
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
                    .then((bounds) => print("bounds: ${bounds.toString()}"));
              },
            );
          },
        ),
      ),
    );
  }
}
