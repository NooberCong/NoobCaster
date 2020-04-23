import 'package:dartz/dartz.dart';
import 'package:noobcaster/core/error/failure.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherData>> getLocalWeather();
  Future<Either<Failure, WeatherData>> getLocationWeather(String location);
  Future<Either<Failure, List<WeatherData>>> getCachedLocationWeather();
}