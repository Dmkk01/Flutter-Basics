import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/weatherTile.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:weather_app/main_widget.dart';

Future<WeatherInfo> fetchWeather () async {
  final zipCode = "02150";
  final apiKey = "Here goes the OpenWeatherMap API Key";
  final requestURL = "http://api.openweathermap.org/data/2.5/weather?zip=${zipCode},fi&units=metric&appid=${apiKey}";

  final response = await http.get(Uri.parse(requestURL));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(json.decode(response.body));
  }
  else {
    throw Exception("Error loading the requested URL");
  }
}

class WeatherInfo {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  WeatherInfo({
    @required this.location,
    @required this.temp,
    @required this.tempMin,
    @required this.tempMax,
    @required this.weather,
    @required this.humidity,
    @required this.windSpeed,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
   return WeatherInfo(
       location: json['name'],
       temp: json['main']['temp'],
       tempMin: json['main']['temp_min'],
       tempMax: json['main']['temp_max'],
       weather: json['weather'][0]['description'],
       humidity: json['main']['humidity'],
       windSpeed: json['wind']['speed']);
  }
}

void main() {
  runApp(MaterialApp(
      title: "Weather App",
      debugShowCheckedModeBanner: false,
      home: MyApp()
      )
  );
}
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState () {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp>{

  Future<WeatherInfo> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          title: Text(
            'Weather App',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
            ),
          ),
          backgroundColor: Colors.deepOrange[200],
          centerTitle: true,
        ),
      body: FutureBuilder<WeatherInfo> (
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainWidget(
                location: snapshot.data.location,
                temp: snapshot.data.temp,
                tempMin: snapshot.data.tempMin,
                tempMax: snapshot.data.tempMax,
                weather: snapshot.data.weather,
                humidity: snapshot.data.humidity,
                windSpeed: snapshot.data.windSpeed
            );
          }
          else if (snapshot.hasError){
            return Center(
              child: Text("${snapshot.error}"),
            );
          }

          return CircularProgressIndicator();
        }
      )
    );
  }
}
