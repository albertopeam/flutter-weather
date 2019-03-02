import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:location/location.dart';

import 'package:weatherapp/weather/weather.dart';
import 'package:weatherapp/weather/forecast.dart';
import 'package:weatherapp/weather/weather_use_case.dart';
import 'mock_current_weather_service.dart';
import 'mock_forecast_service.dart';
import 'mock_location.dart';
import 'location_data_builder.dart';
import 'weather_builder.dart';
import 'forecast_builder.dart';
import 'package:weatherapp/weather/weather_result.dart';

main() {
  
  group('get weather', () {

    MockLocation _mockLocation;
    MockCurrentWeather _mockCurrentWeather;
    MockForecastWeather _mockForecastWeather;

    setUp(() async {
      _mockLocation = MockLocation();
      _mockCurrentWeather = MockCurrentWeather();
      _mockForecastWeather = MockForecastWeather();
    });

    tearDown(() async {
      _mockLocation = null;
      _mockCurrentWeather = null;
      _mockForecastWeather = null;
    });

    test('given location error when get then match error', () async {
      when(_mockLocation.getLocation()).thenThrow(Exception("No Location"));
      
      final sut = WeatherUseCase(_mockLocation, _mockCurrentWeather, _mockForecastWeather);

      expect(sut.get(), throwsException);
    });

    test('given location/network available then match weather', () async {      
      LocationData fakeLocation = LocationDataBuilder()
        .withLat(43)
        .withLon(-8)
        .build();
      when(_mockLocation.getLocation())
        .thenAnswer((_) => Future.value(fakeLocation));
      Weather weather = WeatherBuilder().build();
      when(_mockCurrentWeather.get(43, -8))
        .thenAnswer((_) => Future.value(weather));
      Forecast forecast = ForecastBuilder().build();
      when(_mockForecastWeather.get(43, -8))
        .thenAnswer((_) => Future.value(forecast));

      final sut = WeatherUseCase(_mockLocation, _mockCurrentWeather, _mockForecastWeather);

      expect(await sut.get(), TypeMatcher<WeatherResult>());
    });

  });

}