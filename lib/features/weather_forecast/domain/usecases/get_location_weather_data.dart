import 'package:dartz/dartz.dart';
import 'package:noobcaster/core/error/failure.dart';
import 'package:meta/meta.dart';
import 'package:noobcaster/core/usecases/usecase.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
import 'package:noobcaster/features/weather_forecast/domain/repositories/weather_repository.dart';

class GetLocationWeatherData implements UseCase<WeatherData, Params> {
  final WeatherRepository repository;

  GetLocationWeatherData({@required this.repository});
  @override
  Future<Either<Failure, WeatherData>> call(Params params) async {
    return await repository.getLocationWeather(params.location);
  }
}