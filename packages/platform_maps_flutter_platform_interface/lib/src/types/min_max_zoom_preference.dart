/// Used with [PlatformMapOptions] to wrap min and max zoom. This allows
/// distinguishing between specifying unbounded zooming (null `minZoom` and
/// `maxZoom`) from not specifying anything (null `MinMaxZoomPreference`).
class MinMaxZoomPreference {
  const MinMaxZoomPreference(this.minZoom, this.maxZoom)
      : assert(minZoom == null || maxZoom == null || minZoom <= maxZoom);

  static const unbounded = MinMaxZoomPreference(null, null);

  /// The preferred minimum zoom level or null, if unbounded from below.
  final double? minZoom;

  /// The preferred maximum zoom level or null, if unbounded from above.
  final double? maxZoom;

  /// Converts this object to something serializable in JSON.
  dynamic toJson() => <dynamic>[minZoom, maxZoom];
}
