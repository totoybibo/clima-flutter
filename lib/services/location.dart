import 'package:geolocator/geolocator.dart';

class Location {
  double longitude;
  double latitude;
  Future<Position> getCurrentLocation() async {
    Position position;
    try {
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!isLocationServiceEnabled)
        return null; //check if location services is enable

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.low);

        if (position == null) {
          position = await Geolocator.getLastKnownPosition();
        }
        longitude = position.longitude;
        latitude = position.latitude;
      } else {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          throw 'unable to get location permission';
        }
      }
    } catch (e) {
      print(e);
    }
    return position;
  }
}
