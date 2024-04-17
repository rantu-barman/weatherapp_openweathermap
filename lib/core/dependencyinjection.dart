import 'package:get_it/get_it.dart';

import '../forecast/core/services/forecastservice.dart';
import '../forecast/core/services/weather_local_service.dart';
import 'shared_preferences_manager.dart';

abstract class AppDependencyInjector {
  static final getIt = GetIt.instance;

  static void setupAppDependencies() {
    _getForecastApiService();
    _getLocalWeatherService();
    _getSharedPreferencesManager();
  }

  static void _getForecastApiService() {
    getIt.registerLazySingleton<ForecastApiService>(() => ForecastApiService());
  }

  static void _getLocalWeatherService() {
    getIt.registerLazySingleton<LocalWeatherService>(() => LocalWeatherService());
  }

  static void _getSharedPreferencesManager() {
    getIt.registerLazySingleton<SharedPreferencesManager>(() => SharedPreferencesManager());
  }
}
