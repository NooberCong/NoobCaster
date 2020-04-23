import 'dart:convert';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:noobcaster/core/error/exceptions.dart';
import 'package:noobcaster/features/weather_forecast/data/data%20sources/local_weather_data_source.dart';
import 'package:noobcaster/features/weather_forecast/data/models/weather_forcast_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  LocalWeatherDataSourceImpl localWeatherDataSource;
  
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localWeatherDataSource = LocalWeatherDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });
  group("getCachedLocalWeatherData", () {
    final cachedWeatherData = WeatherDataModel.fromJson(json.decode(fixture("cached_local_weather.json")));
    test("Should get data from shared preferences when there is data", () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(fixture("cached_local_weather.json"));
      //act
      final result = await localWeatherDataSource.getCachedLocalWeatherData();
      //assert
      verify(mockSharedPreferences.getString(CACHED_LOCAL_WEATHER_DATA));
      expect(result, cachedWeatherData);
    });
    test("Should throw cache error when shared preferences return null", () {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //act
      final call = localWeatherDataSource.getCachedLocalWeatherData;
      //assert
      expect(() => call(), throwsA(TypeMatcher<CacheError>()));
    });
  });
  group("getCachedLocationWeatherData", () {
    final cachedWeatherData = (json.decode(fixture("cached_location_weather.json")) as List<dynamic>).map((entry) => WeatherDataModel.fromJson(entry)).toList();
    test("Should get location weather data when there is data", () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(fixture("cached_location_weather.json"));
      //act
      final result = await localWeatherDataSource.getCachedLocationWeatherData();
      //assert
      verify(mockSharedPreferences.getString(CACHED_LOCATION_WEATHER_DATA));
      expect(result, cachedWeatherData);
    });
    test("Should throw cache error when shared preferences return null", () {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //act
      final call = localWeatherDataSource.getCachedLocationWeatherData;
      //assert
      expect(() => call(), throwsA(TypeMatcher<CacheError>()));
    });
    group("cacheLocalWeatherData", () {
      final model = WeatherDataModel.fromJson(json.decode(fixture("cached_local_weather.json")));
      test("Should call toJson method and cache weather data", () {
        //act
        localWeatherDataSource.cacheLocalWeatherData(model);
        //assert
        verify(mockSharedPreferences.setString(CACHED_LOCAL_WEATHER_DATA, json.encode(model.toJson())));
      });
    });
    group("cacheLocationWeatherData", () {
      final modelList = (json.decode(fixture("cached_location_weather.json")) as List<dynamic>).map((entry) => WeatherDataModel.fromJson(entry)).toList();
      final model = WeatherDataModel.fromJson(json.decode(fixture("cached_local_weather.json")));
      test("Should call toJson method and cache weather data", () {
        //arrange
        modelList.add(model);
        when(mockSharedPreferences.getString(CACHED_LOCATION_WEATHER_DATA)).thenReturn(fixture("cached_location_weather.json"));
        //act
        localWeatherDataSource.cacheLocationWeatherData(model);
        //assert
        verify(mockSharedPreferences.setString(CACHED_LOCATION_WEATHER_DATA, json.encode(modelList.map((entry) => entry.toJson()).toList())));
      });
      test("Should make new array of weather models when there is no existing data", () {
        //arrange
        when(mockSharedPreferences.getString(CACHED_LOCATION_WEATHER_DATA)).thenReturn(null);
        //act
        localWeatherDataSource.cacheLocationWeatherData(model);
        //assert
        verify(mockSharedPreferences.setString(CACHED_LOCATION_WEATHER_DATA, json.encode([model.toJson()])));
      });
    });
  });
}