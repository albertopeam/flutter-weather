import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'weather.dart';
import 'forecast.dart';
import 'weather_use_case.dart';
import 'weather_mapper.dart';

class OpenWeatherForecastService implements ForecastService {

  final String _endpoint;
  final Client _client;
  final String _appId;

  OpenWeatherForecastService(this._client, this._endpoint, this._appId);
  
  Future<Forecast> get(double lat, double lon) async {
    final url = _endpoint + "forecast?lat=$lat&lon=$lon&appId=$_appId&units=metric";    
    final response = await _client.get(url);
    if (response != null && response.statusCode == 200) {
      return _mapForecast(json.decode(response.body));
    } else {
      throw Exception("Request error");
    }
  }

  Forecast _mapForecast(Map<String, dynamic> json) {
    final String name =  json['city']['name'];
    final List<dynamic> cities = json['list'] as List;    
    final List<Weather> predictions = cities.map((i) => WeatherMapper.map(i)).toList();
    return Forecast(name: name, predictions: predictions);
  }

}