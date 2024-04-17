import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tabs/tab1.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences _sharedPrefs;
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      GoRouter.of(context).go(Tab1.routeName);
    });
    return const Scaffold();
  }
}
