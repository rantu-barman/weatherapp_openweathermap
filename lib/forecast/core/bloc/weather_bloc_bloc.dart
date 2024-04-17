import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/dependencyinjection.dart';
import '../../../core/shared_preferences_manager.dart';
import '../../models/forecastmodel.dart';
import '../../models/weather_hive.dart';
import '../services/forecastservice.dart';
import '../services/weather_local_service.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  final ForecastApiService _forecastApiService = AppDependencyInjector.getIt.get();
  final SharedPreferencesManager sharedprefs = AppDependencyInjector.getIt.get();
  final LocalWeatherService localWeatherService = AppDependencyInjector.getIt.get();

  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  FutureOr<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherBlocState> emit,
  ) async {
    emit(WeatherBlocLoading());
    try {
      ForecastWeatherModel? weather;

      final coordinates = event.position;
      bool apicall = await sharedprefs.shouldUpdate();
      if (apicall) {
        weather = await _forecastApiService.fetchWeather(coordinates.latitude, coordinates.longitude);
      } else {
        final ForecastWeatherModelHive? hiveModel = localWeatherService.fetchCurrentWeather();
        if (hiveModel != null) {
          weather = hiveModel.toForecastWeatherModel();
        } else {
          weather = await _forecastApiService.fetchWeather(coordinates.latitude, coordinates.longitude);
        }
      }
      if (weather != null) {
        final location = await _getAddress(coordinates.latitude, coordinates.longitude);
        emit(WeatherBlocSuccess(weather, location ?? ""));
      } else {
        emit(WeatherBlocFailure());
      }
    } catch (_) {
      emit(WeatherBlocFailure());
    }
  }

  Future<String?> _getAddress(double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return '${placemark.subLocality}, ${placemark.locality}';
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting address: $e');
      }
    }
    return null;
  }
}
