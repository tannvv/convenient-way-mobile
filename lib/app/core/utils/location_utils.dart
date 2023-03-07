import 'dart:math';

import 'package:latlong2/latlong.dart';

class LocationUtils {
  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static double calculateDistance2(LatLng coord1, LatLng coord2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((coord2.latitude - coord1.latitude) * p) / 2 +
        cos(coord1.latitude * p) *
            cos(coord2.latitude * p) *
            (1 - cos((coord2.longitude - coord1.longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }
}
