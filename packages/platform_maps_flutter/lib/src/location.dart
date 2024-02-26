part of '../platform_maps_flutter.dart';

/// A pair of latitude and longitude coordinates, stored as degrees.
class LatLng {
  /// Creates a geographical location specified in degrees [latitude] and
  /// [longitude].
  ///
  /// The latitude is clamped to the inclusive interval from -90.0 to +90.0.
  ///
  /// The longitude is normalized to the half-open interval from -180.0
  /// (inclusive) to +180.0 (exclusive)
  const LatLng(double latitude, double longitude)
      : latitude = (latitude < -90.0 ? -90.0 : (90.0 < latitude ? 90.0 : latitude)),
        longitude = (longitude + 180.0) % 360.0 - 180.0;

  /// The latitude in degrees between -90.0 and 90.0, both inclusive.
  final double latitude;

  /// The longitude in degrees between -180.0 (inclusive) and 180.0 (exclusive).
  final double longitude;

  @override
  String toString() => '$runtimeType($latitude, $longitude)';

  static LatLng _fromAppleLatLng(apple_maps.LatLng latLng) =>
      LatLng(latLng.latitude, latLng.longitude);

  static LatLng _fromGoogleLatLng(google_maps.LatLng latLng) =>
      LatLng(latLng.latitude, latLng.longitude);

  apple_maps.LatLng get appleLatLng => apple_maps.LatLng(
        latitude,
        longitude,
      );

  google_maps.LatLng get googleLatLng => google_maps.LatLng(
        latitude,
        longitude,
      );

  static List<google_maps.LatLng> googleMapsLatLngsFromList(List<LatLng> latlngs) {
    List<google_maps.LatLng> googleMapsLatLngs = [];
    for (var latlng in latlngs) {
      googleMapsLatLngs.add(latlng.googleLatLng);
    }
    return googleMapsLatLngs;
  }

  static List<apple_maps.LatLng> appleMapsLatLngsFromList(List<LatLng> latlngs) {
    List<apple_maps.LatLng> appleMapsLatLngs = [];
    for (var latlng in latlngs) {
      appleMapsLatLngs.add(latlng.appleLatLng);
    }
    return appleMapsLatLngs;
  }
}

class LatLngBounds {
  /// Creates geographical bounding box with the specified corners.
  ///
  /// The latitude of the southwest corner cannot be larger than the
  /// latitude of the northeast corner.
  LatLngBounds({required this.southwest, required this.northeast})
      : assert(southwest.latitude <= northeast.latitude);

  static LatLngBounds _fromAppleLatLngBounds(apple_maps.LatLngBounds bounds) => LatLngBounds(
        southwest: LatLng._fromAppleLatLng(bounds.southwest),
        northeast: LatLng._fromAppleLatLng(bounds.northeast),
      );

  static LatLngBounds _fromGoogleLatLngBounds(google_maps.LatLngBounds bounds) => LatLngBounds(
        southwest: LatLng._fromGoogleLatLng(bounds.southwest),
        northeast: LatLng._fromGoogleLatLng(bounds.northeast),
      );

  /// The southwest corner of the rectangle.
  final LatLng southwest;

  /// The northeast corner of the rectangle.
  final LatLng northeast;

  apple_maps.LatLngBounds get appleLatLngBounds => apple_maps.LatLngBounds(
        southwest: southwest.appleLatLng,
        northeast: northeast.appleLatLng,
      );

  google_maps.LatLngBounds get googleLatLngBounds => google_maps.LatLngBounds(
        southwest: southwest.googleLatLng,
        northeast: northeast.googleLatLng,
      );

  bool contains(LatLng point) {
    return _containsLatitude(point.latitude) && _containsLongitude(point.longitude);
  }

  bool _containsLatitude(double lat) {
    return (southwest.latitude <= lat) && (lat <= northeast.latitude);
  }

  bool _containsLongitude(double lng) {
    if (southwest.longitude <= northeast.longitude) {
      return southwest.longitude <= lng && lng <= northeast.longitude;
    } else {
      return southwest.longitude <= lng || lng <= northeast.longitude;
    }
  }
}
