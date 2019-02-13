import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'forecast.dart';
import 'weather_use_case.dart';

class OpenWeatherForecastService implements ForecastService {

  final String _endpoint;
  final Client _client;
  final String _appId;

  OpenWeatherForecastService(this._client, this._endpoint, this._appId);
  
  Future<Forecast> get(double lat, double lon) async {
    final url = _endpoint + "forecast?lat=$lat&lon=$lon&appId=$_appId&units=metric";    
    final response = await _client.get(url);
    if (response.statusCode == 200) {
      return _mapForecast(json.decode(response.body));
    } else {
      throw Exception("Request error");
    }
  }

  Forecast _mapForecast(Map<String, dynamic> json) {
    final String name =  json['city']['name'];
    final List<dynamic> cities = json['list'] as List;
    final List<Prediction> predictions = cities.map((i) => _mapPrediction(i)).toList();
    return Forecast(name: name, predictions: predictions);
  }

  Prediction _mapPrediction(Map<String, dynamic> json) {
    Map<String, dynamic> weather =  json['weather'][0];
    Map<String, dynamic> main = json['main'];
    Map<String, dynamic> wind = json['wind'];
    final timestamp = json['dt'];
    DateTime dateTime = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return Prediction(
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