import 'dart:convert';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:noobcaster/core/error/exceptions.dart';
import 'package:noobcaster/core/util/time_zone_handler.dart';
import 'package:noobcaster/features/weather_forecast/data/data_sources/remote_weather_data_source.dart';
import 'package:noobcaster/features/weather_forecast/data/models/weather_forcast_model.dart';
import 'package:noobcaster/keys/key.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockTimezoneHandler extends Mock implements TimezoneHandler {}

void main() {
  RemoteWeatherDataSourceImpl remoteDataSource;
  MockHttpClient mockHttpClient;
  MockTimezoneHandler mockTimezoneHandler;
  setUp(() {
    mockHttpClient = MockHttpClient();
    mockTimezoneHandler = MockTimezoneHandler();
    remoteDataSource = RemoteWeatherDataSourceImpl(
        client: mockHttpClient, timezoneHandler: mockTimezoneHandler);
  });

  void _getWeatherDataTest() {
    Position position = Position(latitude: 12.2, longitude: -6.4);
    Placemark placemark = Placemark(
      position: position,
      locality: "Tay Ninh",
      name: "Viet Nam",
    );
    test("Should make call to the right endpoint with the right coordinates",
        () {
      //arrange
      when(mockHttpClient.get(any, headers: anyNamed("headers"))).thenAnswer(
          (_) async => http.Response(fixture("remote_weather.json"), 200));
      when(mockTimezoneHandler.dateTimeFromUnixAndTimezone(any, any))
          .thenReturn(DateTime(1212, 12, 12, 12, 12));
      //act
      remoteDataSource.getLocalWeatherData(placemark);
      //assert
      verify(mockHttpClient.get(
          Uri.http("api.openweathermap.org", "/data/2.5/onecall", {
            "lon": position.longitude.toString(),
            "lat": position.latitude.toString(),
            "appid": API_KEY
          }),
          headers: {'Content-Type': 'application/json'}));
    });
    test("Should return weather data when call to api is successful", () async {
      //arrange
      when(mockHttpClient.get(any, headers: anyNamed("headers"))).thenAnswer(
          (_) async => http.Response(fixture("remote_weather.json"), 200));
      when(mockTimezoneHandler.dateTimeFromUnixAndTimezone(any, any))
          .thenReturn(DateTime(1212, 12, 12, 12, 12));
      //act
      final result = await remoteDataSource.getLocalWeatherData(placemark);
      //assert
      expect(
        result,
        WeatherDataModel.fromServerJsonWithTimezone(
          json.decode(fixture("remote_weather.json")),
          displayName: "Tay Ninh",
          handler: mockTimezoneHandler,
        ),
      );
    });
    test("Should get regional time from timezone", () async {
      //arrange
      when(mockHttpClient.get(any, headers: anyNamed("headers"))).thenAnswer(
          (_) async => http.Response(fixture("remote_weather.json"), 200));
      when(mockTimezoneHandler.dateTimeFromUnixAndTimezone(any, any))
          .thenReturn(DateTime(1212, 12, 12, 12, 12));
      //act
      await remoteDataSource.getLocalWeatherData(placemark);
      //assert
      verify(mockTimezoneHandler.dateTimeFromUnixAndTimezone(
          "Asia/Ho_Chi_Minh", 1586264189));
    });
    test("Should throw server error when response status is not 200", () {
      //arrange
      when(mockHttpClient.get(any, headers: anyNamed("headers")))
          .thenAnswer((_) async => http.Response("Error", 404));
      //act
      final call = remoteDataSource.getLocalWeatherData;
      //assert
      expect(() => call(placemark), throwsA(TypeMatcher<ServerError>()));
    });
  }

  group("getLocalWeatherData", () {
    _getWeatherDataTest();
  });
  group("getLocationWeatherData", () {
    _getWeatherDataTest();
  });
}
