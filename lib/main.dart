import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'core/dependencyinjection.dart';
import 'core/shared_preferences_manager.dart';
import 'forecast/core/services/weather_local_service.dart';

void main() async {
  AppDependencyInjector.setupAppDependencies();
  await Hive.initFlutter('documents');
  await AppDependencyInjector.getIt.get<LocalWeatherService>().init();
  await AppDependencyInjector.getIt.get<SharedPreferencesManager>().init();
  runApp(const MyApp());
}
