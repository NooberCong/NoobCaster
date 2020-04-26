import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:noobcaster/core/error/exceptions.dart';
import 'package:noobcaster/features/weather_forecast/data/models/weather_forcast_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:noobcaster/secrets/key.dart';

abstract class RemoteWeatherDataSource {
  Future<WeatherDataModel> getLocalWeatherData(Placemark placemark);
  Future<WeatherDataModel> getLocationWeatherData(Placemark placemark);
}

class RemoteWeatherDataSourceImpl implements RemoteWeatherDataSource {
  final http.Client client;

  RemoteWeatherDataSourceImpl({@required this.client});
  @override
  Future<WeatherDataModel> getLocalWeatherData(Placemark placemark) async {
    return await _getWeatherData(
      placemark.position.latitude,
      placemark.position.longitude,
      _getValidDisplayName(placemark.locality, placemark.name),
    );
  }

  @override
  Future<WeatherDataModel> getLocationWeatherData(Placemark placemark) async {
    return await _getWeatherData(
      placemark.position.latitude,
      placemark.position.longitude,
      _getValidDisplayName(placemark.locality, placemark.name),
    );
  }

  Future<WeatherDataModel> _getWeatherData(
      double lat, double lon, String displayName) async {
    final response = await client.get(
        Uri.http("api.openweathermap.org", "/data/2.5/onecall", {
          "lon": lon.toString(),
          "lat": lat.toString(),
          "appid": API_KEY,
        }),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return WeatherDataModel.fromJson(json.decode(response.body),
          displayName: displayName);
    }
    throw ServerError();
  }

  _getValidDisplayName(String locality, String name) {
    if (locality.length > 0) {
      return locality;
    } else if (name.length > 0) {
      return name;
    }
    return "Unknown";
  }
}
