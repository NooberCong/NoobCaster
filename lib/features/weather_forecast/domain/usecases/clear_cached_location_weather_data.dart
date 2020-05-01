import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:noobcaster/core/error/failure.dart';
import 'package:noobcaster/core/usecases/usecase.dart';
import 'package:noobcaster/features/weather_forecast/domain/repositories/weather_repository.dart';

class ClearCachedLocationWeatherData implements UseCase<void, NoParams> {
  final WeatherRepository repository;
  ClearCachedLocationWeatherData({@required this.repository});
  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.clearCachedLocationWeatherData();
  }
}
