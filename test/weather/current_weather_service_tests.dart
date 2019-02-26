import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart';
import 'mock_http_client.dart';

import 'package:weatherapp/common/constants.dart';
import 'package:weatherapp/weather/current_weather_service.dart';
import 'package:weatherapp/weather/weather.dart';

main() {
  group('current weather', () {
    
    final mockClient = MockHttpClient();
    final lat = 43.0;
    final lon = -8.0;
    final _appId = "abc123";
    final url = Constants.endpoint + "weather?lat=$lat&lon=$lon&appId=$_appId&units=metric";

    test('given network down when get current weather then throw exception', () async {          
      when(mockClient.get(url)).thenAnswer((_) async => Response('Not Found', 404));

      final sut = OpenWeatherCurrentService(mockClient, Constants.endpoint, Constants.appId);
      expect(sut.get(lat, lon), throwsException);
    });

    test('given available network when get current weather then map result correctly', () async {
      final json = """ 
        {
          "weather": [
              {
                  "id": 800,
                  "main": "Clear",
                  "description": "clear sky",
                  "icon": "01d"
              }
          ],
          "main": {
              "temp": 19.38,
              "pressure": 1023,
              "humidity": 48,
              "temp_min": 17.78,
              "temp_max": 22
          },  
          "wind": {
            "speed": 3.1,
            "deg": 10
          },              
          "dt": 1551199809,          
          "name": "Perillo"
        }
      """;
      when(mockClient.get(url)).thenAnswer((_) async => Response(json, 200));
      
      final sut = OpenWeatherCurrentService(mockClient, Constants.endpoint, _appId);
      final weather = await sut.get(lat, lon);
      expect(weather, TypeMatcher<Weather>());
    });

  });
}