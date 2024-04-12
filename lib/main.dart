import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/dependencyinjection.dart';

void main(){
   AppDependencyInjector.setupAppDependencies();
  runApp(const MyApp());
}
