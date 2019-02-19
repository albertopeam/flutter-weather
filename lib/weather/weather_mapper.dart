import 'weather.dart';

class WeatherMapper {
  
  static Weather map(Map<String, dynamic> json) {
    Map<String, dynamic> weather =  json['weather'][0];
    Map<String, dynamic> main = json['main'];
    Map<String, dynamic> wind = json['wind'];
    final timestamp = json['dt'];
    DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return Weather(
      name: json['name'] != null ? json['name'] : "",
      description: weather['description'],
      icon: weather['icon'],
      temperature: main['temp'] * 1.0,
      minTemperature: main['temp_min'] * 1.0,
      maxTemperature: main['temp_max'] * 1.0,
      pressure: main['pressure'] * 1.0,
      humidity: main['humidity'] * 1.0,
      windSpeed: wind['speed'] * 1.0,
      dateTime: dateTime
    );
  }

}