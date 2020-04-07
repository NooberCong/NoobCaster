import 'package:noobcaster/core/usecases/usecase.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
import 'package:noobcaster/features/weather_forecast/domain/repositories/weather_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_location_weather_data.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  GetLocationWeatherData usecase;
  MockWeatherRepository mockWeatherRepository;
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetLocationWeatherData(repository: mockWeatherRepository);
  });
  final tLocation = "Tay Ninh";
  final tWeatherData = WeatherData(
      currentTemp: 34.2,
      daily: [],
      hourly: [],
      description: "Clear sky",
      humidity: 32,
      icon: "01d",
      sunrise: 1586558776,
      sunset: 1586603197,
      uvi: 13.2);
  test("Should get location weather data from the repository", () async {
    //arrange
    when(mockWeatherRepository.getLocationWeather(any))
        .thenAnswer((_) async => Right(tWeatherData));
    //act
    final result = await usecase(Params(location: tLocation));
    //assert
    expect(result, Right(tWeatherData));
    verify(mockWeatherRepository.getLocationWeather(tLocation));
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
