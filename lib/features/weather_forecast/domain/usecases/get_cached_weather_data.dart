import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:noobcaster/core/error/failure.dart';
import 'package:noobcaster/core/usecases/usecase.dart';
import 'package:noobcaster/features/weather_forecast/domain/repositories/weather_repository.dart';

class GetCachedWeatherData implements UseCase<Map<String, dynamic>, NoParams> {
  final WeatherRepository repository;
  GetCachedWeatherData({@required this.repository});
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(NoParams noParams) async {
    return repository.getCachedWeather();
  }
}
