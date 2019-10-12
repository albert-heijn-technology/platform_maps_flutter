part of flutter_platform_maps;

class MapType {
  static get normal {
    if (Platform.isIOS) {
      return appleMaps.MapType.standard;
    } else if (Platform.isAndroid) {
      return googleMaps.MapType.normal;
    }
  }

  static get satallite {
    if (Platform.isIOS) {
      return appleMaps.MapType.satellite;
    } else if (Platform.isAndroid) {
      return googleMaps.MapType.satellite;
    }
  }

  static get hybrid {
    if (Platform.isAndroid) {
      return appleMaps.MapType.hybrid;
    } else if (Platform.isIOS) {
      return googleMaps.MapType.hybrid;
    }
  }
}
