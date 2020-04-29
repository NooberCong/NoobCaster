import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:noobcaster/core/error/exceptions.dart';
import 'package:noobcaster/core/error/failure.dart';
import 'package:meta/meta.dart';
import 'package:noobcaster/core/network/network_info.dart';
import 'package:noobcaster/features/weather_forecast/data/data%20sources/local_weather_data_source.dart';
import 'package:noobcaster/features/weather_forecast/data/data%20sources/remote_weather_data_source.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
import 'package:noobcaster/features/weather_forecast/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteWeatherDataSource remoteDataSource;
  final LocalWeatherDataSource localDataSource;
  final NetworkInfo networkInfo;
  final Geolocator geolocator;

  WeatherRepositoryImpl(
      {@required this.remoteDataSource,
      @required this.localDataSource,
      @required this.geolocator,
      @required this.networkInfo});
  @override
  Future<Either<Failure, WeatherData>> getLocalWeather() async {
    final isOnline = await networkInfo.isOnline;
    final gpsEnabled = await geolocator.isLocationServiceEnabled();
    if (!gpsEnabled) {
      return Left(PermissionFailure());
    }
    if (isOnline) {
      try {
        final currentPos = await geolocator.getCurrentPosition();
        final placemark = await geolocator.placemarkFromPosition(currentPos);
        final weatherData =
            await remoteDataSource.getLocalWeatherData(placemark[0]);
        localDataSource.cacheLocalWeatherData(weatherData);
        return Right(weatherData);
      } on ServerError {
        return Left(ServerFailure());
      } on PlatformException {
        return Left(PermissionFailure());
      }
    } else {
      try {
        final cachedWeatherData =
            await localDataSource.getCachedLocalWeatherData();
        return Right(cachedWeatherData);
      } on Exception {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, WeatherData>> getLocationWeather(
      String location) async {
    final isOnline = await networkInfo.isOnline;
    if (isOnline) {
      try {
        final placemarks = await geolocator.placemarkFromAddress(location);
        if (_isEmpty(placemarks)) {
          return Left(InputFailure());
        }
        final weatherData =
            await remoteDataSource.getLocationWeatherData(placemarks[0]);
        localDataSource.cacheLocationWeatherData(weatherData);
        return Right(weatherData);
      } on ServerError {
        return Left(ServerFailure());
      } on PlatformException {
        return Left(InputFailure());
      }
    } else {
      try {
        final weatherData =
            await localDataSource.getCachedLocationWeatherData(location);
        return Right(weatherData);
      } on Exception {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getCachedWeather() async {
    try {
      final cachedLocationWeatherData =
          await localDataSource.getCachedWeatherData();
      return Right(cachedLocationWeatherData);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  bool _isEmpty(List<Placemark> placemarks) {
    return placemarks.length == 0;
  }
}
