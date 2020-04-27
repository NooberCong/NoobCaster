import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noobcaster/core/error/failure.dart';
import 'package:noobcaster/core/usecases/usecase.dart';
import 'package:noobcaster/core/util/input_validator.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_local_weather_data.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_location_weather_data.dart';
import 'package:noobcaster/features/weather_forecast/presentation/bloc/weather_data_bloc.dart';

class MockGetLocalWeatherData extends Mock implements GetLocalWeatherData {}

class MockInputValidator extends Mock implements InputValidator {}

class MockGetLocationWeatherData extends Mock
    implements GetLocationWeatherData {}

void main() {
  WeatherDataBloc bloc;
  MockGetLocalWeatherData mockGetLocalWeatherData;
  MockGetLocationWeatherData mockGetLocationWeatherData;
  MockInputValidator mockInputValidator;
  final city = "Tay Ninh";
  final dateTime = DateTime(1212, 12, 12, 12, 12);
  final data = WeatherData(
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
    bloc = WeatherDataBloc(
        inputValidator: mockInputValidator,
        local: mockGetLocalWeatherData,
        location: mockGetLocationWeatherData);
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
      when(mockGetLocalWeatherData(any)).thenAnswer((_) async => Right(data));
      //assert later
      final expectedStates = [
        WeatherDataInitial(),
        WeatherDataLoading(),
        WeatherDataLoaded(data: data)
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
          .thenAnswer((_) async => Right(data));
      //assert later
      final expectedStates = [
        WeatherDataInitial(),
        WeatherDataLoading(),
        WeatherDataLoaded(data: data)
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
  });
}
