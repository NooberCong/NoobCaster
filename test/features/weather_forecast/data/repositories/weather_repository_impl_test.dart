import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noobcaster/core/error/exceptions.dart';
import 'package:noobcaster/core/error/failure.dart';
import 'package:noobcaster/core/network/network_info.dart';
import 'package:noobcaster/core/settings/app_settings.dart';
import 'package:noobcaster/features/weather_forecast/data/data_sources/local_weather_data_source.dart';
import 'package:noobcaster/features/weather_forecast/data/data_sources/remote_weather_data_source.dart';
import 'package:noobcaster/features/weather_forecast/data/models/weather_forcast_model.dart';
import 'package:noobcaster/features/weather_forecast/data/repositories/weather_repository_impl.dart';

class MockRemoteWeatherDataSource extends Mock
    implements RemoteWeatherDataSource {}

class MockAppSettings extends Mock implements AppSettings {}

class MockLocalWeatherDataSource extends Mock
    implements LocalWeatherDataSource {}

class MockGeolocator extends Mock implements Geolocator {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockRemoteWeatherDataSource mockRemoteWeatherDataSource;
  MockLocalWeatherDataSource mockLocalWeatherDataSource;
  MockNetworkInfo mockNetworkInfo;
  WeatherRepositoryImpl repository;
  MockGeolocator mockGeolocator;
  MockAppSettings mockAppSettings;
  final position = Position(latitude: 11.3, longitude: 4.3);
  final placemarks = [Placemark(name: "Tay Ninh", position: position)];
  final dateTime = DateTime(1212, 12, 12, 12, 12);
  final WeatherDataModel model = WeatherDataModel(
      isCached: false,
      isLocal: true,
      currentTemp: 34.2,
      daily: [],
      windspeed: 8.4,
      dateTime: dateTime,
      displayName: "Tay Ninh",
      hourly: [],
      description: "Clear sky",
      humidity: 32,
      icon: "01d",
      sunrise: dateTime,
      sunset: dateTime,
      uvi: 13.2);
  final modelList = [model];
  setUp(() {
    mockRemoteWeatherDataSource = MockRemoteWeatherDataSource();
    mockLocalWeatherDataSource = MockLocalWeatherDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockGeolocator = MockGeolocator();
    mockAppSettings = MockAppSettings();
    repository = WeatherRepositoryImpl(
        remoteDataSource: mockRemoteWeatherDataSource,
        localDataSource: mockLocalWeatherDataSource,
        geolocator: mockGeolocator,
        networkInfo: mockNetworkInfo,
        appSettings: mockAppSettings);
  });
  group("getLocalWeatherData", () {
    setUp(() {
      when(mockGeolocator.placemarkFromPosition(any,
              localeIdentifier: anyNamed("localeIdentifier")))
          .thenAnswer((_) async => placemarks);
      when(mockAppSettings.getLocale()).thenReturn("en_US");
    });
    test("should check if device is online", () async {
      //arrange
      when(mockNetworkInfo.isOnline).thenAnswer((_) async => true);
      when(mockGeolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      //act
      await repository.getLocalWeather();
      //assert
      verify(mockNetworkInfo.isOnline);
    });
    test("Should check if permission is granted", () async {
      //arrange
      when(mockGeolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(mockNetworkInfo.isOnline).thenAnswer((_) async => true);
      //act
      await repository.getLocalWeather();
      //assert
      verify(mockGeolocator.isLocationServiceEnabled());
    });
    test("Should return permission failure when gps is not enabled", () async {
      //arrange
      when(mockGeolocator.getCurrentPosition())
          .thenAnswer((_) async => position);
      when(mockNetworkInfo.isOnline).thenAnswer((_) async => true);
      when(mockGeolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => false);
      //act
      final result = await repository.getLocalWeather();
      //assert
      expect(result, Left(PermissionFailure()));
    });
    test(
        "Should make call to geolocator to get coordinates when gps is enabled",
        () async {
      //arrange
      when(mockGeolocator.getCurrentPosition())
          .thenAnswer((_) async => position);
      when(mockNetworkInfo.isOnline).thenAnswer((_) async => true);
      when(mockGeolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      //act
      await repository.getLocalWeather();
      //assert
      verify(mockGeolocator.getCurrentPosition());
    });
    test("Should use location and identifier to get placemark", () async {
      //arrange
      when(mockGeolocator.getCurrentPosition())
          .thenAnswer((_) async => position);
      when(mockGeolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      when(mockNetworkInfo.isOnline).thenAnswer((_) async => true);
      //act
      await repository.getLocalWeather();
      //assert
      verify(mockGeolocator.placemarkFromPosition(position,
          localeIdentifier: "en_US"));
    });
    group("Device has gps on and is online", () {
      setUp(() {
        when(mockNetworkInfo.isOnline).thenAnswer((_) async => true);
        when(mockGeolocator.isLocationServiceEnabled())
            .thenAnswer((_) async => true);
      });
      test(
          "Should return permission failure when geolocator permission status is not granted",
          () async {
        //arrange
        when(mockGeolocator.getCurrentPosition())
            .thenThrow(PlatformException(code: "PERMISSION_DENIED"));
        //act
        final result = await repository.getLocalWeather();
        //assert
        expect(result, Left(PermissionFailure()));
      });
      test("Should successfully return weather model when device is online",
          () async {
        //arrange
        when(mockRemoteWeatherDataSource.getLocalWeatherData(any))
            .thenAnswer((_) async => model);
        when(mockGeolocator.getCurrentPosition())
            .thenAnswer((_) async => position);
        //act
        final result = await repository.getLocalWeather();
        //assert
        verify(mockRemoteWeatherDataSource.getLocalWeatherData(placemarks[0]));
        expect(result, Right(model));
      });
      test("Should cache weather data when the call to api is successful",
          () async {
        //arrange
        when(mockRemoteWeatherDataSource.getLocalWeatherData(placemarks[0]))
            .thenAnswer((_) async => model);
        when(mockGeolocator.getCurrentPosition())
            .thenAnswer((_) async => position);
        //act
        await repository.getLocalWeather();
        //assert
        verify(mockRemoteWeatherDataSource.getLocalWeatherData(placemarks[0]));
        verify(mockLocalWeatherDataSource.cacheLocalWeatherData(model));
      });
      test("Should return sever failure when call to api is unsuccessful",
          () async {
        //arrange
        when(mockRemoteWeatherDataSource.getLocalWeatherData(placemarks[0]))
            .thenThrow(ServerError());
        when(mockGeolocator.getCurrentPosition())
            .thenAnswer((_) async => position);
        //act
        final result = await repository.getLocalWeather();
        //assert
        verify(mockRemoteWeatherDataSource.getLocalWeatherData(placemarks[0]));
        verifyZeroInteractions(mockLocalWeatherDataSource);
        expect(result, Left(ServerFailure()));
      });
    });
    group("Device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isOnline).thenAnswer((_) async => false);
        when(mockGeolocator.isLocationServiceEnabled())
            .thenAnswer((_) async => true);
      });
      test("Should not make call to api when offline", () {
        //act
        repository.getLocalWeather();
        //assert
        verifyZeroInteractions(mockRemoteWeatherDataSource);
      });
      test("Should attempt to get last cached weather data when offline",
          () async {
        //arrange
        when(mockLocalWeatherDataSource.getCachedLocalWeatherData())
            .thenAnswer((_) async => model);
        //act
        final result = await repository.getLocalWeather();
        //assert
        expect(result, Right(model));
        verify(mockLocalWeatherDataSource.getCachedLocalWeatherData());
      });
      test("Should return cache failure when local weather data source fails",
          () async {
        //arrange
        when(mockLocalWeatherDataSource.getCachedLocalWeatherData())
            .thenThrow(CacheError());
        //act
        final result = await repository.getLocalWeather();
        //assert
        verify(mockLocalWeatherDataSource.getCachedLocalWeatherData());
        expect(result, Left(CacheFailure()));
      });
    });
  });

  group("getLocationWeatherData", () {
    final placemark =
        Placemark(position: Position(latitude: 12, longitude: 12));
    setUp(() {
      when(mockGeolocator.placemarkFromAddress(any,
              localeIdentifier: anyNamed("localeIdentifier")))
          .thenAnswer((_) async => [placemark]);
      when(mockAppSettings.getLocale()).thenReturn("en_US");
    });
    final String tLocation = "Tay Ninh";
    final WeatherDataModel model = WeatherDataModel(
        isCached: false,
        isLocal: true,
        windspeed: 8.4,
        currentTemp: 34.2,
        dateTime: dateTime,
        daily: [],
        hourly: [],
        displayName: "Tay Ninh",
        description: "Clear sky",
        humidity: 32,
        icon: "01d",
        sunrise: dateTime,
        sunset: dateTime,
        uvi: 13.2);
    test("should check if device is online", () async {
      //arrange
      when(mockNetworkInfo.isOnline).thenAnswer((_) async => true);
      when(mockGeolocator.isLocationServiceEnabled())
          .thenAnswer((_) async => true);
      //act
      await repository.getLocationWeather(tLocation);
      //assert
      verify(mockNetworkInfo.isOnline);
    });
    group("Device is online", () {
      setUp(() {
        when(mockNetworkInfo.isOnline).thenAnswer((_) async => true);
        when(mockGeolocator.placemarkFromAddress(any))
            .thenAnswer((_) async => placemarks);
      });
      test("Should get placemark from location data", () async {
        //act
        await repository.getLocationWeather(tLocation);
        //assert
        verify(mockGeolocator.placemarkFromAddress(tLocation,
            localeIdentifier: "en_US"));
      });
      test("Should return InputFailure when no placemark matched", () async {
        //arrange
        when(mockGeolocator.placemarkFromAddress(any,
                localeIdentifier: anyNamed("localeIdentifier")))
            .thenAnswer((_) async => []);
        //act
        final result = await repository.getLocationWeather(tLocation);
        //assert
        expect(result, Left(InputFailure()));
      });
      test("Should pass placemark to remotedatasource", () async {
        //act
        await repository.getLocationWeather(tLocation);
        //assert
        verify(mockRemoteWeatherDataSource.getLocationWeatherData(placemark));
      });
      test("Should successfully return weather model when device is online",
          () async {
        //arrange
        when(mockRemoteWeatherDataSource.getLocationWeatherData(any))
            .thenAnswer((_) async => model);
        //act
        final result = await repository.getLocationWeather(tLocation);
        //assert
        verify(mockRemoteWeatherDataSource.getLocationWeatherData(placemark));
        expect(result, Right(model));
      });
      test("Should cache location weather data when call to api is successful",
          () async {
        //arrange
        when(mockRemoteWeatherDataSource.getLocationWeatherData(any))
            .thenAnswer((_) async => model);
        //act
        await repository.getLocationWeather(tLocation);
        //assert
        verify(mockLocalWeatherDataSource.cacheLocationWeatherData(model));
      });
      test("Should return sever failure when call to api is unsuccessful",
          () async {
        //arrange
        when(mockRemoteWeatherDataSource.getLocationWeatherData(any))
            .thenThrow(ServerError());
        //act
        final result = await repository.getLocationWeather(tLocation);
        //assert
        verify(mockRemoteWeatherDataSource.getLocationWeatherData(placemark));
        verifyZeroInteractions(mockLocalWeatherDataSource);
        expect(result, Left(ServerFailure()));
      });
    });
    group("Device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isOnline).thenAnswer((_) async => false);
        when(mockGeolocator.isLocationServiceEnabled())
            .thenAnswer((_) async => true);
      });
      test("Should not make call to api when offline", () {
        //act
        repository.getLocalWeather();
        //assert
        verifyZeroInteractions(mockRemoteWeatherDataSource);
      });
      test("Should return WeatherDataModel if data is in cache", () async {
        //arrange
        when(mockLocalWeatherDataSource.getCachedLocationWeatherData(any))
            .thenAnswer((_) async => model);
        //act
        final result = await repository.getLocationWeather(tLocation);
        //assert
        expect(result, Right(model));
      });
      test("Should return CacheFailure when data is not in cache", () async {
        //arrange
        when(mockLocalWeatherDataSource.getCachedLocationWeatherData(any))
            .thenThrow(CacheError());
        //act
        final result = await repository.getLocationWeather(tLocation);
        //assert
        expect(result, Left(ServerFailure()));
      });
    });
  });
  group("getCachedLocationWeather", () {
    test("Should call getCachedWeatherData", () async {
      //arrange
      when(mockLocalWeatherDataSource.getCachedWeatherData())
          .thenAnswer((_) async => {"local": model, "location": modelList});
      //act
      await repository.getCachedWeather();
      //assert
      verify(mockLocalWeatherDataSource.getCachedWeatherData());
    });
    test("Should return cache failure when localDataSource fails", () async {
      //arrange
      when(mockLocalWeatherDataSource.getCachedWeatherData())
          .thenThrow(CacheError());
      //act
      final result = await repository.getCachedWeather();
      //assert
      expect(result, Left(CacheFailure()));
    });
  });
  group("clearCachedLocationWeatherData", () {
    test("Should call method on localWeatherSource", () async {
      //act
      await repository.clearCachedLocationWeatherData();
      //assert
      verify(mockLocalWeatherDataSource.clearLocationWeatherDataCache());
    });
    test("Should return null", () async {
      //act
      final result = await repository.clearCachedLocationWeatherData();
      //assert
      expect(result, Right(null));
    });
  });
}
