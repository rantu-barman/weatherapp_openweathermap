
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../navbar.dart';
import '../home.dart';
import '../tabs/tab1.dart';
import '../tabs/tab2.dart';



final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const Home();
        },
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: Tab1.routeName,
            builder: (BuildContext context, GoRouterState state) => const Tab1(),
          ),
          GoRoute(
            path: Tab2.routeName,
            builder: (BuildContext context, GoRouterState state) => const Tab2(),
            routes: const <RouteBase>[
              // GoRoute(
              //   path: ReportsIndividualReportPage.routeName,
              //   name: ReportsIndividualReportPage.routeName,
              //   builder: (context, state) => ReportsIndividualReportPage(
              //     uiObjectModel: state.extra != null
              //         ? state.extra! as ReportsIndividualReportsUiObjectModel
              //         : ReportsIndividualReportsUiObjectModel(
              //             reportsModel: ReportsModel(id: 1),
              //           ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    ],
  );
}
