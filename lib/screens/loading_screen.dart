import 'package:flutter/material.dart';
import 'location_screen.dart';
import '../services/weather.dart';
import '../services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherModel weather = WeatherModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            dynamic data = await weather.getLocalWeather();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationScreen(data: data),
              ),
            );
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
