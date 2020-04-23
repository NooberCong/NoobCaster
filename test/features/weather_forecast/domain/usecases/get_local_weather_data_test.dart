import 'package:noobcaster/core/usecases/usecase.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
import 'package:noobcaster/features/weather_forecast/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_local_weather_data.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  GetLocalWeatherData usecase;
  MockWeatherRepository mockWeatherRepository;
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetLocalWeatherData(repository: mockWeatherRepository);
  });
  final tWeatherData = WeatherData(
      currentTemp: 34.2,
      displayName: "Tay Ninh",
      daily: [],
      hourly: [],
      description: "Clear sky",
      humidity: 32,
      icon: "01d",
      sunrise: 1586558776,
      sunset: 1586603197,
      uvi: 13.2);
  test("Should get local weather data from the repository", () async {
    //arrange
    when(mockWeatherRepository.getLocalWeather())
        .thenAnswer((_) async => Right(tWeatherData));
    //act
    final result = await usecase(NoParams());
    //assert
    expect(result, Right(tWeatherData));
    verify(mockWeatherRepository.getLocalWeather());
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
