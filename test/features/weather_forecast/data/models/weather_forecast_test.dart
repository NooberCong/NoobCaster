import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:noobcaster/core/util/time_zone_handler.dart';
import 'package:noobcaster/features/weather_forecast/data/models/weather_forcast_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockTimezoneHandler extends Mock implements TimezoneHandler {}

void main() {
  final datetime = DateTime(1212, 12, 12, 12, 12);
  final mockTimezoneHandler = MockTimezoneHandler();
  test("Should be a subclass of weather", () {
    //arrange
    when(mockTimezoneHandler.dateTimeFromUnixAndTimezone(any, any))
        .thenReturn(datetime);
    //assert
    expect(
        WeatherDataModel.fromServerJsonWithTimezone(
          json.decode(fixture("remote_weather.json")),
          displayName: "Tay Ninh",
          handler: mockTimezoneHandler,
        ),
        isA<WeatherData>());
  });
  test("Should return a valid weather model from json", () {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture("remote_weather.json"));
    //arrage
    when(mockTimezoneHandler.dateTimeFromUnixAndTimezone(any, any))
        .thenReturn(datetime);
    //act
    final model = WeatherDataModel.fromServerJsonWithTimezone(
      json.decode(fixture("remote_weather.json")),
      displayName: "Tay Ninh",
      handler: mockTimezoneHandler,
    );
    final result = WeatherDataModel.fromServerJsonWithTimezone(
      jsonMap,
      displayName: "Tay Ninh",
      handler: mockTimezoneHandler,
    );
    //assert
    expect(result, model);
  });
  test("Should return a valid json from model", () {
    //arrage
    when(mockTimezoneHandler.dateTimeFromUnixAndTimezone(any, any))
        .thenReturn(datetime);
    //act
    final model = WeatherDataModel.fromServerJsonWithTimezone(
      json.decode(fixture("remote_weather.json")),
      displayName: "Tay Ninh",
      handler: mockTimezoneHandler,
    );
    final Map<String, dynamic> jsonMap = model.toJson();

    final result = model.toJson();
    //assert
    expect(result, jsonMap);
  });
}
