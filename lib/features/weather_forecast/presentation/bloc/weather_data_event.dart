part of 'weather_data_bloc.dart';

abstract class WeatherDataEvent extends Equatable {
  const WeatherDataEvent();
}

class GetLocalWeatherEvent extends WeatherDataEvent {
  @override
  List<Object> get props => [];
}

class GetLocationWeatherEvent extends WeatherDataEvent {
  final String location;
  GetLocationWeatherEvent(this.location);
  @override
  List<Object> get props => [];
}

class RefreshWeatherDataEvent extends WeatherDataEvent {
  final WeatherData data;

  RefreshWeatherDataEvent(this.data);
  @override
  List<Object> get props => [data];
}

class GetCachedWeatherDataEvent extends WeatherDataEvent {
  @override
  List<Object> get props => [];
}

class GetDrawerWeatherDataEvent extends WeatherDataEvent {
  final WeatherData backup;
  GetDrawerWeatherDataEvent({@required this.backup});
  @override
  List<Object> get props => [backup];
}
