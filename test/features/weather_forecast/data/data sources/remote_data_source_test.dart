import 'dart:convert';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:noobcaster/core/error/exceptions.dart';
import 'package:noobcaster/features/weather_forecast/data/data%20sources/remote_weather_data_source.dart';
import 'package:noobcaster/features/weather_forecast/data/models/weather_forcast_model.dart';
import 'package:noobcaster/secrets/key.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  RemoteWeatherDataSourceImpl remoteDataSource;
  MockHttpClient mockHttpClient;
  setUp(() {
    mockHttpClient = MockHttpClient();
    remoteDataSource = RemoteWeatherDataSourceImpl(client: mockHttpClient);
  });

  _getWeatherDataTest() {
    Position position = Position(latitude: 12.2, longitude: -6.4);
    Placemark placemark = Placemark(position: position);
    test("Should make call to the right endpoint with the right coordinates",
        () {
      //arrange
      when(mockHttpClient.get(any, headers: anyNamed("headers"))).thenAnswer(
          (_) async => http.Response(fixture("remote_weather.json"), 200));
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
      //act
      final result = await remoteDataSource.getLocalWeatherData(placemark);
      //assert
      expect(
          result,
          WeatherDataModel.fromJson(
              json.decode(fixture("remote_weather.json"))));
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
