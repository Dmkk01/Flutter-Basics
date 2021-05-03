import 'package:flutter/material.dart';
import 'package:weather_app/weatherTile.dart';
import 'package:intl/intl.dart';

class MainWidget extends StatelessWidget{
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  MainWidget({
    @required this.location,
    @required this.temp,
    @required this.tempMin,
    @required this.tempMax,
    @required this.weather,
    @required this.humidity,
    @required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height/3,
          width: MediaQuery.of(context).size.width,
          color: Colors.deepOrange[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${location.toString()}",
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  "${temp.toInt().toString()}°",
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                "High of ${tempMax.toInt().toString()}°, low of ${tempMin.toInt().toString()}°",
                style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900
                ),
              )],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: [
                WeatherTile( icon: Icons.thermostat_outlined, title: "Temperature", subtitle: "${temp.toInt().toString()}°"),
                WeatherTile( icon: Icons.filter_drama_outlined, title: "Weather", subtitle: "${toBeginningOfSentenceCase(weather.toString())}"),
                WeatherTile( icon: Icons.wb_sunny, title: "Humidity", subtitle: "${humidity.toString()}%"),
                WeatherTile( icon: Icons.waves_outlined, title: "Wind Speed", subtitle: "${windSpeed.toInt().toString()} km/h"),
              ],
            ),
          ),
        )
      ],
    );
  }
}



