import 'package:platform_maps_flutter_platform_interface/src/platform_bitmap_descriptor.dart';
import 'package:platform_maps_flutter_platform_interface/src/platform_camera_update.dart';
import 'package:platform_maps_flutter_platform_interface/src/platform_maps_platform_controller.dart';
import 'package:platform_maps_flutter_platform_interface/src/platform_maps_platform_widget.dart';
import 'package:platform_maps_flutter_platform_interface/src/types.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// Interface for a platform implementation of a PlatformMaps.
abstract class PlatformMapsPlatform extends PlatformInterface {
  /// Creates a new [PlatformMapsPlatform].
  PlatformMapsPlatform() : super(token: _token);

  static final Object _token = Object();

  static PlatformMapsPlatform? _instance;

  /// The instance of [PlatformMapsPlatform] to use.
  static PlatformMapsPlatform? get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [PlatformMapsPlatform] when they register themselves.
  static set instance(PlatformMapsPlatform? instance) {
    if (instance == null) {
      throw AssertionError('Platform interfaces can only be set to a non-null instance');
    }

    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Create a new [PlatformPlatformMapsWidget].
  ///
  /// This function should only be called by the app-facing package.
  /// Look at using [PlatformMap] in `platform_maps_flutter` instead.
  PlatformMapsPlatformWidget createPlatformMapsPlatformWidget(
    PlatformMapsPlatformWidgetCreationParams params,
  ) {
    throw UnimplementedError(
        'createPlatformMapsPlatformWidget is not implemented on the current platform.');
  }

  /// Create a new [PlatformBitmapDescriptor].
  /// This function should only be called by the app-facing package.
  PlatformBitmapDescriptor<T> createBitmapDescriptor<T>() {
    throw UnimplementedError('createBitmapDescriptor is not implemented on the current platform.');
  }

  PlatformMapsPlatformController createMapsController() {
    throw UnimplementedError('createMapsController is not implemented on the current platform.');
  }

  PlatformCameraUpdate createPlatformCameraUpdate() {
    throw UnimplementedError('createCameraUpdate is not implemented on the current platform.');
  }
}
