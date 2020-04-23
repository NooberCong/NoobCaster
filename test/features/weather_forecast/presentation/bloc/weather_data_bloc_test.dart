import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
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
  final data = WeatherData(
      currentTemp: 12.2,
      daily: [],
      description: "hot",
      displayName: "Tay Ninh",
      hourly: [],
      humidity: 32,
      icon: "02d",
      sunrise: 39483948,
      sunset: 3094389,
      uvi: 10.0);
  setUp(() {
    mockGetLocalWeatherData = MockGetLocalWeatherData();
    mockGetLocationWeatherData = MockGetLocationWeatherData();
    bloc = WeatherDataBloc(
        validator: mockInputValidator, local: mockGetLocalWeatherData, location: mockGetLocationWeatherData);
  });
  test('Initial state should be weatherdataloading', () {
    //assert
    expect(bloc.initialState, WeatherDataLoading());
  });
  group('GetLocalWeatherData', () {
    //assert later

  });
  group("GetLocationWeatherData", () {
    test('Should return InputFailure when input is empty', () {
      //arrange
      when(mockInputValidator.validate(any)).thenReturn(false);
      //assert later
      final expectedStates = [
        WeatherDataLoading(),
        WeatherDataError(message: INPUT_FAILURE_MESSAGE)
      ];
      expectLater(bloc.state, emitsInOrder(expectedStates));
    });
  });
}
