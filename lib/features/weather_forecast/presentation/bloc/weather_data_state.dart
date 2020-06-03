part of 'weather_data_bloc.dart';

abstract class WeatherDataState extends Equatable {
  const WeatherDataState();
}

class WeatherDataInitial extends WeatherDataState {
  @override
  List<Object> get props => [];
}

class WeatherDataLoading extends WeatherDataState {
  @override
  List<Object> get props => [];
}

class WeatherDataLoaded extends WeatherDataState {
  final WeatherData data;
  const WeatherDataLoaded({@required this.data});
  @override
  List<Object> get props => [data];
}

class WeatherDataError extends WeatherDataState {
  final String message;
  const WeatherDataError({@required this.message});
  @override
  List<Object> get props => [message];
}

class CacheWeatherDataLoaded extends WeatherDataState {
  final Map<String, dynamic> cachedData;
  const CacheWeatherDataLoaded({@required this.cachedData});
  @override
  List<Object> get props => [cachedData];
}

class CacheWeatherDataError extends WeatherDataState {
  @override
  List<Object> get props => [];
}
