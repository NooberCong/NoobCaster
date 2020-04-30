import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:noobcaster/core/error/failure.dart';
import 'package:noobcaster/core/usecases/usecase.dart';
import 'package:noobcaster/core/util/input_validator.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_cached_weather_data.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_local_weather_data.dart';
import 'package:noobcaster/features/weather_forecast/domain/usecases/get_location_weather_data.dart';
import 'package:noobcaster/features/weather_forecast/domain/entities/weather.dart';
part 'weather_data_event.dart';
part 'weather_data_state.dart';

const String SERVER_FAILURE_MESSAGE =
    "Server error: Something went wrong while contacting server";
const String CACHE_FAILURE_MESSAGE =
    "Cache error: No cached data found for offline mode";
const String PERMISSION_FAILURE_MESSAGE =
    "Permission error: NooberCaster was not permitted to locate device location";
const String INPUT_FAILURE_MESSAGE =
    "Input error: no location matched the input, please try again";

class WeatherDataBloc extends Bloc<WeatherDataEvent, WeatherDataState> {
  final GetLocalWeatherData getLocalWeatherData;
  final GetLocationWeatherData getLocationWeatherData;
  final GetCachedWeatherData getCachedLocationWeatherData;
  final InputValidator validator;

  WeatherDataBloc(
      {@required InputValidator inputValidator,
      @required GetCachedWeatherData cached,
      @required GetLocalWeatherData local,
      @required GetLocationWeatherData location})
      : assert(inputValidator != null),
        assert(local != null),
        assert(location != null),
        assert(cached != null),
        validator = inputValidator,
        getLocalWeatherData = local,
        getLocationWeatherData = location,
        getCachedLocationWeatherData = cached;
  @override
  WeatherDataState get initialState => WeatherDataInitial();

  @override
  Stream<WeatherDataState> mapEventToState(
    WeatherDataEvent event,
  ) async* {
    if (event is GetLocationWeatherEvent) {
      yield WeatherDataLoading();
      yield* _getLocationWeatherResult(event.location);
    } else if (event is GetLocalWeatherEvent) {
      yield WeatherDataLoading();
      yield* _getLocalWeatherResult();
    } else if (event is RefreshWeatherDataEvent) {
      yield WeatherDataLoading();
      if (event.data.isLocal) {
        yield* _getLocalWeatherResult();
      } else {
        yield* _getLocationWeatherResult(event.data.displayName);
      }
    } else if (event is GetCachedWeatherDataEvent) {
      yield* _getCachedWeatherDataResults();
    } else if (event is ReloadStateEvent) {
      final blocState = event.currentState;
      yield* _reloadedState(blocState);
    }
  }

  Stream<WeatherDataState> _reloadedState(WeatherDataState blocState) async* {
    if (blocState is WeatherDataError) {
      yield WeatherDataError(message: blocState.message);
    } else if (blocState is WeatherDataLoading) {
      yield WeatherDataLoading();
    } else if (blocState is WeatherDataLoaded) {
      yield WeatherDataLoaded(data: blocState.data);
    } else {
      yield WeatherDataInitial();
    }
  }

  Stream<WeatherDataState> _getLocationWeatherResult(String location) async* {
    final isValid = validator.validate(location);
    if (!isValid) {
      yield WeatherDataError(message: INPUT_FAILURE_MESSAGE);
    } else {
      final failureOrData =
          await getLocationWeatherData(Params(location: location));
      yield failureOrData.fold(
          (failure) => WeatherDataError(message: _mapFailureToMessage(failure)),
          (data) => WeatherDataLoaded(data: data));
    }
  }

  Stream<WeatherDataState> _getLocalWeatherResult() async* {
    final failureOrData = await getLocalWeatherData(NoParams());
    yield failureOrData.fold(
        (failure) => WeatherDataError(message: _mapFailureToMessage(failure)),
        (data) => WeatherDataLoaded(data: data));
  }

  String _mapFailureToMessage(Failure failure) {
    return failure is ServerFailure
        ? SERVER_FAILURE_MESSAGE
        : failure is CacheFailure
            ? CACHE_FAILURE_MESSAGE
            : failure is PermissionFailure
                ? PERMISSION_FAILURE_MESSAGE
                : INPUT_FAILURE_MESSAGE;
  }

  Stream<WeatherDataState> _getCachedWeatherDataResults() async* {
    final cachedData = await getCachedLocationWeatherData(NoParams());
    yield cachedData.fold((failure) => CacheWeatherDataError(),
        (data) => CacheWeatherDataLoaded(cachedData: data));
  }
}
