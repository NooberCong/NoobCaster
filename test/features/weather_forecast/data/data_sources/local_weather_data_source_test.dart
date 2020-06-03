import 'dart:convert';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:noobcaster/core/error/exceptions.dart';
import 'package:noobcaster/features/weather_forecast/data/data_sources/local_weather_data_source.dart';
import 'package:noobcaster/features/weather_forecast/data/models/weather_forcast_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  LocalWeatherDataSourceImpl localWeatherDataSource;
  final cachedLocalWeatherData = WeatherDataModel.fromCacheJson(json
      .decode(fixture("cached_local_weather.json")) as Map<String, dynamic>);
  final cachedLocationWeatherData =
      (json.decode(fixture("cached_location_weather.json")) as List<dynamic>)
          .map((entry) =>
              WeatherDataModel.fromCacheJson(entry as Map<String, dynamic>))
          .toList();

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localWeatherDataSource =
        LocalWeatherDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });
  group("getCachedLocalWeatherData", () {
    test("Should get data from shared preferences when there is data",
        () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture("cached_local_weather.json"));
      //act
      final result = await localWeatherDataSource.getCachedLocalWeatherData();
      //assert
      verify(mockSharedPreferences.getString(CACHED_LOCAL_WEATHER_DATA));
      expect(result, cachedLocalWeatherData);
    });
    test("Should throw cache error when shared preferences return null", () {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //act
      final call = localWeatherDataSource.getCachedLocalWeatherData;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheError>()));
    });
  });
  group("getCachedLocationWeatherData", () {
    test("Should get location weather data when there is data", () async {
      //arrange
      when(mockSharedPreferences.getString(CACHED_LOCAL_WEATHER_DATA))
          .thenReturn(fixture("cached_local_weather.json"));
      when(mockSharedPreferences.getString(CACHED_LOCATION_WEATHER_DATA))
          .thenReturn(fixture("cached_location_weather.json"));
      //act
      final result = await localWeatherDataSource.getCachedWeatherData();
      //assert
      verify(mockSharedPreferences.getString(CACHED_LOCAL_WEATHER_DATA));
      verify(mockSharedPreferences.getString(CACHED_LOCATION_WEATHER_DATA));
      expect(result["local"], cachedLocalWeatherData);
      expect(result["location"], cachedLocationWeatherData);
    });
  });
  test("Should throw cache error when shared preferences return null", () {
    //arrange
    when(mockSharedPreferences.getString(any)).thenReturn(null);
    //act
    final call = localWeatherDataSource.getCachedWeatherData;
    //assert
    expect(() => call(), throwsA(const TypeMatcher<CacheError>()));
  });
  group("cacheLocalWeatherData", () {
    final model = WeatherDataModel.fromCacheJson(json
        .decode(fixture("cached_local_weather.json")) as Map<String, dynamic>);
    test("Should call toJson method and cache weather data", () {
      //act
      localWeatherDataSource.cacheLocalWeatherData(model);
      //assert
      verify(mockSharedPreferences.setString(
          CACHED_LOCAL_WEATHER_DATA, json.encode(model.toJson())));
    });
  });
  group("cacheLocationWeatherData", () {
    final modelList =
        (json.decode(fixture("cached_location_weather.json")) as List<dynamic>)
            .map((entry) =>
                WeatherDataModel.fromCacheJson(entry as Map<String, dynamic>))
            .toList();
    final model = WeatherDataModel.fromCacheJson(json
        .decode(fixture("cached_local_weather.json")) as Map<String, dynamic>);
    test("Should call toJson method and cache weather data", () {
      //arrange
      modelList.add(model);
      when(mockSharedPreferences.getString(CACHED_LOCATION_WEATHER_DATA))
          .thenReturn(fixture("cached_location_weather.json"));
      //act
      localWeatherDataSource.cacheLocationWeatherData(model);
      //assert
      verify(mockSharedPreferences.setString(CACHED_LOCATION_WEATHER_DATA,
          json.encode(modelList.map((entry) => entry.toJson()).toList())));
    });
    test(
        "Should make new array of weather models when there is no existing data",
        () {
      //arrange
      when(mockSharedPreferences.getString(CACHED_LOCATION_WEATHER_DATA))
          .thenReturn(null);
      //act
      localWeatherDataSource.cacheLocationWeatherData(model);
      //assert
      verify(mockSharedPreferences.setString(
          CACHED_LOCATION_WEATHER_DATA, json.encode([model.toJson()])));
    });
  });
  group("getCachedLocationWeatherData", () {
    test("Should return WeatherDataModel when cache hit", () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture("cached_location_weather.json"));
      //act
      final result =
          await localWeatherDataSource.getCachedLocationWeatherData("In cache");
      //assert
      expect(
          result,
          WeatherDataModel.fromCacheJson(
              json.decode(fixture("cached_location_weather.json"))[0]
                  as Map<String, dynamic>));
    });
    test("Should throw cache error when cache miss", () {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture("cached_location_weather.json"));
      //act
      final call = localWeatherDataSource.getCachedLocationWeatherData;
      //assert
      expect(
          () => call("Not in cache"), throwsA(const TypeMatcher<CacheError>()));
    });
    test("Should move the matching json to top of list", () async {
      final jsonList =
          json.decode(fixture("cached_location_weather.json")) as List<dynamic>;
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture("cached_location_weather.json"));
      //act
      await localWeatherDataSource.getCachedLocationWeatherData("In cache");
      //assert
      verify(mockSharedPreferences.setString(CACHED_LOCATION_WEATHER_DATA,
          json.encode(jsonList.reversed.toList())));
    });
  });
  test("Should empty cached location weather data", () {
    //act
    localWeatherDataSource.clearLocationWeatherDataCache();
    //assert
    verify(mockSharedPreferences.setString(
        CACHED_LOCATION_WEATHER_DATA, json.encode([])));
  });
}
