import 'package:get_it/get_it.dart';

import '../forecast/core/services/forecastservice.dart';



abstract class AppDependencyInjector {
  static final getIt = GetIt.instance;

  static void setupAppDependencies() {
    _getForecastApiService();
  }



  static void _getForecastApiService() {
    getIt.registerLazySingleton<ForecastApiService>(() => ForecastApiService());
  }
}
