import 'dart:convert';
import 'package:noobcaster/features/weather_forecast/data/models/weather_forcast_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final model =
      WeatherDataModel.fromJson(json.decode(fixture("remote_weather.json")));
  test("Should be a subclass of weather", () {
    //assert
    expect(model, isA<WeatherData>());
  });
  test("Should return a valid weather model from json", () {
    //arrange
    final Map<String, dynamic> jsonMap =
        json.decode(fixture("remote_weather.json"));
    //act
    final result = WeatherDataModel.fromJson(jsonMap);
    //assert
    expect(result, model);
  });
  test("Should return a valid json from model", () {
    final Map<String, dynamic> jsonMap = model.toJson();
    //act
    final result = model.toJson();
    //assert
    expect(result, jsonMap);
  });
}
