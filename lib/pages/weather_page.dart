// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_flutter/models/weather_model.dart';
import 'package:weather_app_flutter/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService("fa23a0481b9ef5f17d6be49e9c9794e9");
  Weather? _weather;

  //  fetch weather
  _fetchWeather() async {
    String cityName =
        await _weatherService.getCurrentCity(); // get current city
    try {
      final weather = await _weatherService.getWeather(cityName); // get weather
      setState(() => _weather = weather);
    } catch (e) {
      print(e);
    }
  }

  // weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloudy.json';

      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/foggy.json';

      case 'snow':
        return 'assets/snowy.json';

      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';

      case 'thunderstorm':
        return 'assets/thunder.json';

      case 'clear':
        return 'assets/sunny.json';

      default:
        return 'assets/sunny.json';
    }
  }

  // init state
  @override
  void initState() {
    super.initState();
    _fetchWeather(); // fetch weather on startup
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 5),
                Text(_weather?.cityName ?? "loading city...",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w200))
              ],
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text("${_weather?.temperature.round()}°C",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w200)),
          ],
        ),
      ),
    );
  }
}
