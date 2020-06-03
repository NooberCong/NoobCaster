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
  const GetLocationWeatherEvent(this.location);
  @override
  List<Object> get props => [];
}

class RefreshWeatherDataEvent extends WeatherDataEvent {
  final WeatherData data;

  const RefreshWeatherDataEvent(this.data);
  @override
  List<Object> get props => [data];
}

class GetCachedWeatherDataEvent extends WeatherDataEvent {
  @override
  List<Object> get props => [];
}

class ReloadStateEvent extends WeatherDataEvent {
  final WeatherDataState currentState;
  const ReloadStateEvent({@required this.currentState});
  @override
  List<Object> get props => [currentState];
}
