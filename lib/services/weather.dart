import 'location.dart';
import 'networking.dart';
import 'package:geolocator/geolocator.dart';

const urlString = 'https://api.openweathermap.org/data/2.5/weather?';
const apiKey = '61005dbc91b0c64be4508192256a7a3d';

class WeatherModel {
  Location loc = Location();
  Future<dynamic> getLocalWeather() async {
    dynamic data;
    try {
      Position pos = await loc.getCurrentLocation();
      double longitude = pos.longitude;
      double latitude = pos.latitude;
      String url =
          urlString + 'lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
      print(url);
      NetworkHelper net = NetworkHelper(url);
      data = await net.getData();
      return data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getCityWeather(String cityName) async {
    dynamic data;
    try {
      Position pos = await loc.getCurrentLocation();
      double longitude = pos.longitude;
      double latitude = pos.latitude;
      String url = urlString + 'q=$cityName&appid=$apiKey&units=metric';
      print(url);
      NetworkHelper net = NetworkHelper(url);
      data = await net.getData();
      return data;
    } catch (e) {
      print(e);
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
