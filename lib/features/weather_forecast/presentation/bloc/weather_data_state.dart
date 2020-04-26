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
  WeatherDataLoaded({@required this.data});
  @override
  List<Object> get props => [data];
}

class WeatherDataError extends WeatherDataState {
  final String message;
  WeatherDataError({@required this.message});
  @override
  List<Object> get props => [message];
}
