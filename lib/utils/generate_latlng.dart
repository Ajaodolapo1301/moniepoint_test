import 'dart:math';
import 'package:latlong2/latlong.dart';

List<LatLng> generateLatLng(LatLng originalLatLng, int count) {
  double offset = 0.01;
  List<LatLng> locations = [originalLatLng];

  for (int i = 1; i < count; i++) {
    double newLatitude =
        originalLatLng.latitude + (Random().nextDouble() * 2 - 1) * offset * i*5;
    double newLongitude =
        originalLatLng.longitude + (Random().nextDouble() * 2 - 1) * offset * i*5;

    locations.add(LatLng(newLatitude, newLongitude));
  }
  return locations;
}
