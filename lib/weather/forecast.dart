class Forecast {

  final String name;
  final List<Prediction> predictions;

  Forecast({this.name, this.predictions});

}

class Prediction {

  final String description;
  final String icon;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final double pressure;
  final double humidity;
  final double windSpeed;
  final DateTime dateTime;

  Prediction({this.description, this.icon, this.temperature, this.minTemperature, this.maxTemperature, this.pressure, this.humidity, this.windSpeed, this.dateTime});

}