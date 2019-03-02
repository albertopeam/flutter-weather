import 'package:location/location.dart';

class LocationDataBuilder {

  double _lat;
  double _lon;

  LocationDataBuilder withLat(double lat) {
    this._lat = lat;
    return this;
  }

  LocationDataBuilder withLon(double lon) {
    this._lon = lon;
    return this;
  }  

  LocationData build() {
    Map<String, double> dataMap = Map<String, double>();
    dataMap["latitude"] = _lat;
    dataMap["longitude"] = _lon;
    dataMap["accuracy"] = 0;
    dataMap["altitude"] = 0;
    dataMap["speed"] = 0;
    dataMap["speed_accuracy"] = 0;
    return LocationData.fromMap(dataMap);
  }
}