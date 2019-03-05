import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'weather_builder.dart';
import 'forecast_builder.dart';
import 'package:weatherapp/weather/weather_use_case.dart';
import 'package:weatherapp/weather/weather_result.dart';
import 'package:weatherapp/weather/widget/current_weather_widget.dart';

void main() {

  MockWeatherUseCase mockWeatherUseCase;
  Widget sut;

  setUp(() async {
      mockWeatherUseCase = MockWeatherUseCase();
      sut = MediaQuery(
        data: MediaQueryData(), 
        child: MaterialApp(home: CurrentWeatherPage(weatherUseCase: mockWeatherUseCase))
      );
  });

  tearDown(() async {
      mockWeatherUseCase = null;
      sut = null;
  });

  testWidgets('given weather then it is shown as expected', (WidgetTester tester) async {
    WeatherResult result = WeatherResult(weather: WeatherBuilder().build(), forecast: ForecastBuilder().build());
    when(mockWeatherUseCase.get()).thenAnswer((_) => Future.value(result));

    await tester.pumpWidget(sut); 
    Key progressKey = CurrentWeatherPage.progressKey;
    expect(find.byKey(progressKey), findsOneWidget);

    await tester.pump();
    expect(find.text(result.weather.name), findsOneWidget);
    expect(find.byKey(CurrentWeatherPage.progressKey), findsNothing);
  });

  testWidgets("given error then it is show an error", (WidgetTester tester) async {    
    when(mockWeatherUseCase.get()).thenAnswer((_) => Future.error("an error"));

    await tester.pumpWidget(sut); 
    Key progressKey = CurrentWeatherPage.progressKey;
    expect(find.byKey(progressKey), findsOneWidget);

    await tester.pump();
    expect(find.text("an error"), findsOneWidget);
    expect(find.byKey(CurrentWeatherPage.weatherKey), findsNothing);
    expect(find.byKey(CurrentWeatherPage.progressKey), findsNothing);
  });

}

class MockWeatherUseCase extends Mock implements WeatherUseCase {}