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
  final dateTime = DateTime(1212, 12, 12, 12, 12);
  final tWeatherData = WeatherData(
      isCached: false,
      isLocal: true,
      dateTime: dateTime,
      currentTemp: 34.2,
      feelsLike: 30.3,
      windspeed: 8.4,
      daily: [],
      hourly: [],
      description: "Clear sky",
      displayName: "Tay Ninh",
      humidity: 32,
      icon: "01d",
      sunrise: dateTime,
      sunset: dateTime,
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
