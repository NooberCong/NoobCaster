import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noobcaster/core/error/failure.dart';
import 'package:noobcaster/core/usecases/usecase.dart';
import 'package:noobcaster/core/util/input_validator.dart';
import 'package:noobcaster/features/weather_forecast/data/models/weather_forcast_model.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_cached_location_weather_data.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_local_weather_data.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_location_weather_data.dart';
import 'package:noobcaster/features/weather_forecast/presentation/bloc/weather_data_bloc.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockGetLocalWeatherData extends Mock implements GetLocalWeatherData {}

class MockInputValidator extends Mock implements InputValidator {}

class MockGetLocationWeatherData extends Mock
    implements GetLocationWeatherData {}

class MockGetCachedLocationWeatherData extends Mock
    implements GetCachedLocationWeatherData {}

void main() {
  WeatherDataBloc bloc;
  MockGetLocalWeatherData mockGetLocalWeatherData;
  MockGetLocationWeatherData mockGetLocationWeatherData;
  MockGetCachedLocationWeatherData mockGetCachedLocationWeatherData;
  MockInputValidator mockInputValidator;
  final city = "Tay Ninh";
  final dateTime = DateTime(1212, 12, 12, 12, 12);
  final localData = WeatherData(
      isCached: false,
      isLocal: true,
      windspeed: 8.4,
      currentTemp: 12.2,
      daily: [],
      dateTime: dateTime,
      description: "hot",
      displayName: "Tay Ninh",
      hourly: [],
      humidity: 32,
      icon: "02d",
      sunrise: dateTime,
      sunset: dateTime,
      uvi: 10.0);
  final locationData = WeatherData(
      isCached: false,
      isLocal: false,
      windspeed: 8.4,
      currentTemp: 12.2,
      daily: [],
      dateTime: dateTime,
      description: "hot",
      displayName: "Tay Ninh",
      hourly: [],
      humidity: 32,
      icon: "02d",
      sunrise: dateTime,
      sunset: dateTime,
      uvi: 10.0);
  setUp(() {
    mockInputValidator = MockInputValidator();
    mockGetLocalWeatherData = MockGetLocalWeatherData();
    mockGetLocationWeatherData = MockGetLocationWeatherData();
    mockGetCachedLocationWeatherData = MockGetCachedLocationWeatherData();
    bloc = WeatherDataBloc(
      inputValidator: mockInputValidator,
      local: mockGetLocalWeatherData,
      location: mockGetLocationWeatherData,
      cached: mockGetCachedLocationWeatherData,
    );
  });
  test('Initial state should be WeatherDataInitial', () {
    //assert
    expect(bloc.initialState, WeatherDataInitial());
  });
  group('GetLocalWeatherData', () {
    test("Should call getlocation usecase", () async {
      //act
      bloc.add(GetLocalWeatherEvent());
      await untilCalled(mockGetLocalWeatherData(any));
      //assert
      verify(mockGetLocalWeatherData(NoParams()));
    });
    test(
        "Should emit [WeatherDataInitial, WeatherDataLoading, WeatherDataLoaded] when call is successful",
        () async {
      //arrange
      when(mockGetLocalWeatherData(any))
          .thenAnswer((_) async => Right(localData));
      //assert later
      final expectedStates = [
        WeatherDataInitial(),
        WeatherDataLoading(),
        WeatherDataLoaded(data: localData)
      ];
      expectLater(bloc, emitsInOrder(expectedStates));
      //act
      bloc.add(GetLocalWeatherEvent());
    });
    test(
        "Should emit [WeatherDataInitial, WeatherDataLoading, WeatherDataError] when call is unsuccessful",
        () async {
      //arrange
      when(mockGetLocalWeatherData(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expectedStates = [
        WeatherDataInitial(),
        WeatherDataLoading(),
        WeatherDataError(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expectedStates));
      //act
      bloc.add(GetLocalWeatherEvent());
    });
    test(
        "Should emit [WeatherDataInitial, WeatherDataLoading, WeatherDataError] with the right error messsage when call is unsuccessful",
        () async {
      //arrange
      when(mockGetLocalWeatherData(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expectedStates = [
        WeatherDataInitial(),
        WeatherDataLoading(),
        WeatherDataError(message: CACHE_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expectedStates));
      //act
      bloc.add(GetLocalWeatherEvent());
    });
    test(
        "Should emit [WeatherDataLoaded, WeatherDataLoading, WeatherDataLoaded] in refresh event",
        () {
      //arrange
      when(mockGetLocalWeatherData(any))
          .thenAnswer((_) async => Right(localData));
      //assert later
      final expectedStates = [
        WeatherDataInitial(),
        WeatherDataLoading(),
        WeatherDataLoaded(data: localData)
      ];
      expectLater(bloc, emitsInOrder(expectedStates));
      //act
      bloc.add(RefreshWeatherDataEvent(localData));
    });
  });
  group("GetLocationWeatherData", () {
    test('Should return InputFailure when validation fails', () {
      //arrange
      when(mockInputValidator.validate(any)).thenReturn(false);
      //assert later
      final expectedStates = [
        WeatherDataInitial(),
        WeatherDataLoading(),
        WeatherDataError(message: INPUT_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expectedStates));
      //act
      bloc.add(GetLocationWeatherEvent("Invalid location or empty string"));
    });
    test("Should call getlocation usecase with the right location", () async {
      //arrange
      when(mockInputValidator.validate(any)).thenReturn(true);
      //act
      bloc.add(GetLocationWeatherEvent(city));
      await untilCalled(mockGetLocationWeatherData(any));
      //assert
      verify(mockGetLocationWeatherData(Params(location: city)));
    });
    test(
        "Should emit [WeatherDataInitial, WeatherDataLoading, WeatherDataLoaded] when call is successful",
        () async {
      //arrange
      when(mockInputValidator.validate(any)).thenReturn(true);
      when(mockGetLocationWeatherData(any))
          .thenAnswer((_) async => Right(locationData));
      //assert later
      final expectedStates = [
        WeatherDataInitial(),
        WeatherDataLoading(),
        WeatherDataLoaded(data: locationData)
      ];
      expectLater(bloc, emitsInOrder(expectedStates));
      //act
      bloc.add(GetLocationWeatherEvent(city));
    });
    test(
        "Should emit [WeatherDataInitial, WeatherDataError] when call is unsuccessful",
        () async {
      //arrange
      when(mockInputValidator.validate(any)).thenReturn(true);
      when(mockGetLocationWeatherData(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expectedStates = [
        WeatherDataInitial(),
        WeatherDataLoading(),
        WeatherDataError(message: SERVER_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expectedStates));
      //act
      bloc.add(GetLocationWeatherEvent(city));
    });
    test(
        "Should emit [WeatherDataInitial, WeatherDataLoading, WeatherDataError] with the right error messsage when call is unsuccessful",
        () async {
      //arrange
      when(mockInputValidator.validate(any)).thenReturn(true);
      when(mockGetLocationWeatherData(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expectedStates = [
        WeatherDataInitial(),
        WeatherDataLoading(),
        WeatherDataError(message: CACHE_FAILURE_MESSAGE)
      ];
      expectLater(bloc, emitsInOrder(expectedStates));
      //act
      bloc.add(GetLocationWeatherEvent(city));
    });
    test(
        "Should emit [WeatherDataLoaded, WeatherDataLoading, WeatherDataLoaded] in refresh event",
        () {
      //arrange
      when(mockInputValidator.validate(any)).thenReturn(true);
      when(mockGetLocationWeatherData(any))
          .thenAnswer((_) async => Right(locationData));
      //assert later
      final expectedStates = [
        WeatherDataInitial(),
        WeatherDataLoading(),
        WeatherDataLoaded(data: locationData)
      ];
      expectLater(bloc, emitsInOrder(expectedStates));
      //act
      bloc.add(RefreshWeatherDataEvent(locationData));
    });
  });
  group("GetCachedWeatherDataEvent", () {
    final cachedData =
        (json.decode(fixture("cached_location_weather.json")) as List<dynamic>)
            .map((entry) => WeatherDataModel.fromCacheJson(entry))
            .toList();
    test(
        "Should emit [WeatherDataInitial, CacheWeatherDataLoaded] if there is cached data",
        () {
      //arrange
      when(mockGetCachedLocationWeatherData.call(any)).thenAnswer(
          (_) async => Right({"local": cachedData[0], "location": cachedData}));
      //assert later
      final expectedStates = [
        WeatherDataInitial(),
        CacheWeatherDataLoaded(
            cachedData: {"local": cachedData[0], "location": cachedData})
      ];
      expectLater(bloc, emitsInOrder(expectedStates));
      //act
      bloc.add(GetCachedWeatherDataEvent());
    });
    test(
        "Should emit [WeatherDataInitial, CacheWeatherDataLoaded] with empty list when there is no cached data",
        () {
      when(mockGetCachedLocationWeatherData.call(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expectedStates = [WeatherDataInitial(), CacheWeatherDataError()];
      expectLater(bloc, emitsInOrder(expectedStates));
      //act
      bloc.add(GetCachedWeatherDataEvent());
    });
  });
  group("getDrawerWeatherData", () {
    final remoteData = WeatherData(
        currentTemp: 12.12,
        daily: [],
        humidity: 13,
        icon: "04d",
        isCached: false,
        isLocal: true,
        sunrise: DateTime.now(),
        sunset: DateTime.now(),
        uvi: 12,
        windspeed: 12,
        dateTime: DateTime.now(),
        description: "Hot",
        displayName: "Tay Ninh",
        hourly: []);
    final cachedData = WeatherDataModel.fromCacheJson(
        json.decode(fixture("cached_local_weather.json")));
    test(
        "Should emit [WeatherDataInitial, WeatherDataLoading, WeatherDataLoaded] with remote weatherdata if call is successful",
        () {
      //arrange
      when(mockGetLocalWeatherData(any))
          .thenAnswer((_) async => Right(remoteData));
      //assert later
      final expectedStates = [
        WeatherDataInitial(),
        WeatherDataLoading(),
        WeatherDataLoaded(data: remoteData)
      ];
      expectLater(bloc, emitsInOrder(expectedStates));
      //act
      bloc.add(GetDrawerWeatherDataEvent(backup: cachedData));
    });
    test(
        "Should emit [WeatherDataInitial, WeatherDataLoading, WeatherDataLoaded] with backup weatherdata if call is unsuccessful",
        () {
      //arrange
      when(mockGetLocalWeatherData(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expectedStates = [
        WeatherDataInitial(),
        WeatherDataLoading(),
        WeatherDataLoaded(data: cachedData)
      ];
      expectLater(bloc, emitsInOrder(expectedStates));
      //act
      bloc.add(GetDrawerWeatherDataEvent(backup: cachedData));
    });
  });
}
