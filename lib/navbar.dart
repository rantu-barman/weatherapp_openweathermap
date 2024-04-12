import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'tabs/tab1.dart';
import 'tabs/tab2.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFFFFFFF),
        type: BottomNavigationBarType.fixed,
        // elevation: 10.0,
        // selectedLabelStyle: GoogleFonts.inter(
        //   fontSize: 8.sp,
        //   fontWeight: FontWeight.w700,
        //   color: const Color(0xFF388087)
        // ),
        // unselectedLabelStyle: GoogleFonts.inter(
        //   fontSize: 8.sp,
        //   fontWeight: FontWeight.w500,
        //   color: const Color(0xFF7E7E7E)
        // ),
        // selectedItemColor: const Color(0xFF388087),
        // unselectedItemColor: const Color(0xFF7E7E7E),
        // showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: 'ForeCast',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Maps',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).location;
    if (location.startsWith(Tab1.routeName)) {
      return 0;
    }
    if (location.startsWith(Tab2.routeName)) {
      return 1;
    }
    return 0;
  }

  static void onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(Tab1.routeName);
      case 1:
        GoRouter.of(context).go(Tab2.routeName);
    }
  }
}
