import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'weather.dart';
import 'weather_use_case.dart';

class OpenWeatherService implements WeatherService{

  final String _endpoint;
  final Client _client;
  final String _appId;

  OpenWeatherService(this._client, this._endpoint, this._appId);
  
  Future<Weather> get(double lat, double lon) async {
    final url = _endpoint + "weather?lat=${lat}&lon=${lon}&appId=${_appId}";    
    final response = await _client.get(url);
    if (response.statusCode == 200) {
      return _map(json.decode(response.body));
    } else {
      throw Exception("Request error");
    }
  }

  Weather _map(Map<String, dynamic> json) {
    Map<String, dynamic> weather =  json['weather'][0];
    Map<String, dynamic> main = json['main'];
    final timestamp = json['dt'];
    DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return Weather(
      name: json['name'],
      description: weather['description'],
      icon: weather['icon'],
      temperature: main['temp'],
      minTemperature: main['temp_min'],
      maxTemperature: main['temp_max'],
      pressure: main['pressure'],
      humidity: main['humidity'],
      dateTime: dateTime
    );
  }

}