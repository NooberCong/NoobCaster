import 'dart:convert';
import 'package:noobcaster/core/error/exceptions.dart';
import 'package:noobcaster/features/weather_forecast/data/models/weather_forcast_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalWeatherDataSource {
  Future<WeatherDataModel> getCachedLocalWeatherData();
  Future<List<WeatherDataModel>> getCachedLocationWeatherData();
  Future<void> cacheLocalWeatherData(WeatherDataModel model);
  Future<void> cacheLocationWeatherData(WeatherDataModel model);
}

const CACHED_LOCAL_WEATHER_DATA = "CACHED_LOCAL_WEATHER_DATA";
const CACHED_LOCATION_WEATHER_DATA = "CACHED_LOCATION_WEATHER_DATA";

class LocalWeatherDataSourceImpl implements LocalWeatherDataSource {
  final SharedPreferences sharedPreferences;

  LocalWeatherDataSourceImpl({@required this.sharedPreferences});
  @override
  Future<void> cacheLocalWeatherData(WeatherDataModel model) {
    return sharedPreferences.setString(
        CACHED_LOCAL_WEATHER_DATA, json.encode(model.toJson()));
  }

  @override
  Future<void> cacheLocationWeatherData(WeatherDataModel model) {
    final cachedData =
        sharedPreferences.getString(CACHED_LOCATION_WEATHER_DATA);
    if (cachedData != null) {
      final locationWeatherData = (json.decode(cachedData) as List<dynamic>)
          .map((entry) => WeatherDataModel.fromCacheJson(entry))
          .toList();
      locationWeatherData.add(model);
      return sharedPreferences.setString(
          CACHED_LOCATION_WEATHER_DATA,
          json.encode(
              locationWeatherData.map((entry) => entry.toJson()).toList()));
    } else {
      return sharedPreferences.setString(
          CACHED_LOCATION_WEATHER_DATA, json.encode([model.toJson()]));
    }
  }

  @override
  Future<WeatherDataModel> getCachedLocalWeatherData() {
    final cachedData = sharedPreferences.getString(CACHED_LOCAL_WEATHER_DATA);
    if (cachedData != null) {
      return Future.value(
          WeatherDataModel.fromCacheJson(json.decode(cachedData)));
    } else {
      throw CacheError();
    }
  }

  @override
  Future<List<WeatherDataModel>> getCachedLocationWeatherData() {
    sharedPreferences.setString(CACHED_LOCATION_WEATHER_DATA, json.encode([]));
    final cachedData =
        sharedPreferences.getString(CACHED_LOCATION_WEATHER_DATA);
    if (cachedData != null) {
      final locationWeatherData = (json.decode(cachedData) as List<dynamic>)
          .map((entry) => WeatherDataModel.fromCacheJson(entry))
          .toList();
      return Future.value(locationWeatherData);
    } else {
      throw CacheError();
    }
  }
}
