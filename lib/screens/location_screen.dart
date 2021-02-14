import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'city_screen.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  final dynamic data;

  LocationScreen({this.data});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temp;
  String icon;
  String message;
  String cityName;
  WeatherModel weather = WeatherModel();
  dynamic data;

  void updateUI() {
    setState(() {
      int condition = data['weather'][0]['id'];
      double _temp = data['main']['temp'];
      temp = _temp.toInt();
      cityName = data['name'];
      print(condition);
      icon = weather.getWeatherIcon(condition);
      print(icon);
      message = weather.getMessage(temp);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      data = await weather.getLocalWeather();
                      updateUI();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      String city = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      data = await weather.getCityWeather(city);

                      updateUI();
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      icon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
