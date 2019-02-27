import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart';
import 'mock_http_client.dart';

import 'package:weatherapp/common/constants.dart';
import 'package:weatherapp/weather/forecast_weather_service.dart';
import 'package:weatherapp/weather/forecast.dart';

main() {

  group('forecast weather', () {

    final _mockClient = MockHttpClient();
    final _lat = 43.0;
    final _lon = -8.0;
    final _appId = "abc123";
    final url = Constants.endpoint + "forecast?lat=$_lat&lon=$_lon&appId=$_appId&units=metric";

    test('given network down when get forecast then throw exception', () async {
      when(_mockClient.get(url)).thenAnswer((_) async => Response('Not Found', 404));

      final sut = OpenWeatherForecastService(_mockClient, Constants.endpoint, Constants.appId);
      expect(sut.get(_lat, _lon), throwsException);
    });

    test('given available network when get forecast then map result correctly', () async {
      final json = """
      {
        "list": [
            {
              "dt": 1551312000,
              "main": {
                  "temp": 9.31,
                  "temp_min": 9.31,
                  "temp_max": 9.45,
                  "pressure": 1030.24,
                  "humidity": 86
              },
              "weather": [
                  {
                      "id": 801,
                      "main": "Clouds",
                      "description": "few clouds",
                      "icon": "02n"
                  }
              ],
              "wind": {
                  "speed": 2.42
              }
            }
          ],
          "city": {        
            "name": "Perillo"      
          }
      }
      """;
      when(_mockClient.get(url)).thenAnswer((_) async => Response(json, 200));
      
      final sut = OpenWeatherForecastService(_mockClient, Constants.endpoint, _appId);
      final forecast = await sut.get(_lat, _lon);
      expect(forecast, TypeMatcher<Forecast>());
    });

  });

}