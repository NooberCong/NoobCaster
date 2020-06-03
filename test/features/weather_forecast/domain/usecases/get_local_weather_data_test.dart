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
  final dateTime = DateTime(1212, 12, 12, 12, 12);
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetLocalWeatherData(repository: mockWeatherRepository);
  });
  final tWeatherData = WeatherData(
      isCached: false,
      isLocal: true,
      currentTemp: 34.2,
      feelsLike: 38.2,
      displayName: "Tay Ninh",
      dateTime: dateTime,
      windspeed: 8.4,
      daily: [],
      hourly: [],
      description: "Clear sky",
      humidity: 32,
      icon: "01d",
      sunrise: dateTime,
      sunset: dateTime,
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
