import 'package:flutter/widgets.dart';
import 'package:platform_maps_flutter_platform_interface/src/platform_maps_platform.dart';
import 'package:platform_maps_flutter_platform_interface/src/types.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class PlatformMapsPlatformWidget extends PlatformInterface {
  /// Creates a new [PlatformMapsPlatformWidget]
  factory PlatformMapsPlatformWidget(PlatformMapsPlatformWidgetCreationParams params) {
    assert(
      PlatformMapsPlatform.instance != null,
      'A platform implementation for `platform_maps_flutter` has not been set. Please '
      'ensure that an implementation of `PlatformMapsPlatform` has been set to '
      '`PlatformMapsPlatform.instance` before use. For unit testing, '
      '`PlatformMapsPlatform.instance` can be set with your own test implementation.',
    );
    final PlatformMapsPlatformWidget platformWidgetDelegate =
        PlatformMapsPlatform.instance!.createPlatformMapsPlatformWidget(params);
    PlatformInterface.verify(platformWidgetDelegate, _token);
    return platformWidgetDelegate;
  }

  /// Used by the platform implementation to create a new
  /// [PlatformMapsPlatformWidget].
  ///
  /// Should only be used by platform implementations because they can't extend
  /// a class that only contains a factory constructor.
  @protected
  PlatformMapsPlatformWidget.implementation(this.params) : super(token: _token);

  static final Object _token = Object();

  /// The parameters used to initialize the [PlatformMapsPlatformWidget].
  final PlatformMapsPlatformWidgetCreationParams params;

  /// Builds a new WebView.
  ///
  /// Returns a Widget tree that embeds the created web view.
  Widget build(BuildContext context);
}
