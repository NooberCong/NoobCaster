import 'dart:convert';
import 'package:noobcaster/core/error/exceptions.dart';
import 'package:noobcaster/features/weather_forecast/data/models/weather_forcast_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalWeatherDataSource {
  Future<WeatherDataModel> getCachedLocalWeatherData();
  Future<WeatherDataModel> getCachedLocationWeatherData(String location);
  Future<Map<String, dynamic>> getCachedWeatherData();
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
      //Remove duplicate values
      final locationWeatherData = _duplicatesRemoved(
          (json.decode(cachedData) as List<dynamic>)
              .map((entry) => WeatherDataModel.fromCacheJson(entry))
              .toList(),
          model);
      if (locationWeatherData.length == 5) {
        locationWeatherData.removeAt(0);
      }
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
  Future<WeatherDataModel> getCachedLocationWeatherData(String location) {
    final cachedData =
        sharedPreferences.getString(CACHED_LOCATION_WEATHER_DATA);
    if (cachedData != null) {
      return _findInCache(cachedData, location);
    } else {
      throw CacheError();
    }
  }

  Future<WeatherDataModel> _findInCache(String cachedData, String location) {
    final jsonList = json.decode(cachedData) as List<dynamic>;
    for (int i = 0; i < jsonList.length; i++) {
      if (jsonList[i]["displayName"] == location) {
        final cacheHit = jsonList.removeAt(i);
        jsonList.add(cacheHit);
        sharedPreferences.setString(
            CACHED_LOCATION_WEATHER_DATA, json.encode(jsonList));
        return Future.value(WeatherDataModel.fromCacheJson(cacheHit));
      }
    }
    throw CacheError();
  }

  @override
  Future<Map<String, dynamic>> getCachedWeatherData() {
    final cachedLocationWeatherData =
        sharedPreferences.getString(CACHED_LOCATION_WEATHER_DATA);
    final cachedLocalWeatherData =
        sharedPreferences.getString(CACHED_LOCAL_WEATHER_DATA);
    if (cachedLocalWeatherData != null) {
      return Future.value({
        "local":
            WeatherDataModel.fromCacheJson(json.decode(cachedLocalWeatherData)),
        "location": cachedLocationWeatherData != null
            ? (json.decode(cachedLocationWeatherData) as List<dynamic>)
                .map((entry) => WeatherDataModel.fromCacheJson(entry))
                .toList()
            : []
      });
    } else {
      throw CacheError();
    }
  }

  List<WeatherDataModel> _duplicatesRemoved(
      List<WeatherDataModel> locationWeatherData, WeatherDataModel model) {
    return locationWeatherData
        .where((cachedModel) => cachedModel.displayName != model.displayName)
        .toList();
  }
}
