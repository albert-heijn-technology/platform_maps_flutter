library platform_maps_flutter;

import 'dart:io';

import 'package:apple_maps_flutter/apple_maps_flutter.dart' as apple_maps;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps;

export 'src/platform_maps.dart';
export 'package:platform_maps_flutter_platform_interface/platform_maps_flutter_platform_interface.dart'
    show MapType;

part 'src/bitmap.dart';
part 'src/camera.dart';
part 'src/cap.dart';
part 'src/circle.dart';
part 'src/controller.dart';
part 'src/joint_type.dart';
part 'src/location.dart';
part 'src/marker.dart';
part 'src/pattern_item.dart';
part 'src/polygon.dart';
part 'src/polyline.dart';
part 'src/ui.dart';
