import 'dart:math' show cos, sqrt, asin;

import 'package:google_maps_flutter/google_maps_flutter.dart';

double distanceCalculator(LatLng origin, LatLng destination) {
  double estDistance;
  // LatLng origin2 = await origin;
  // LatLng destination2 = await destination;

  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((origin.latitude - origin.latitude) * p) / 2 +
      c(origin.latitude * p) *
          c(destination.latitude * p) *
          (1 - c((destination.longitude - origin.longitude) * p)) /
          2;
  estDistance = 12742 * asin(sqrt(a)).toDouble();
  print('distance from calculator is $estDistance');

  return estDistance;
}
