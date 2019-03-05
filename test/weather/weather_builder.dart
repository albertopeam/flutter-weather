import 'package:weatherapp/weather/weather.dart';

class WeatherBuilder {
  Weather build() {
    return Weather(name: "A Coruña", description: "", icon: "", temperature: 0, minTemperature: 0, maxTemperature: 0, pressure: 0, humidity: 0, windSpeed: 0, dateTime: DateTime.now());
  }
}