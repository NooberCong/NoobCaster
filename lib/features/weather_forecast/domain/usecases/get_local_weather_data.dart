import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:noobcaster/core/error/failure.dart';
import 'package:noobcaster/core/usecases/usecase.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
import 'package:noobcaster/features/weather_forecast/domain/repositories/weather_repository.dart';

class GetLocalWeatherData implements UseCase<WeatherData, NoParams> {
  final WeatherRepository repository;

  GetLocalWeatherData({@required this.repository});
  @override
  Future<Either<Failure, WeatherData>> call(NoParams noParams) async {
    return repository.getLocalWeather();
  }
}
