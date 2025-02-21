import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restful_solid_bloc/src/presentation/pages/secondary_page/defined_category_page.dart';
import 'package:restful_solid_bloc/src/presentation/pages/splash_screen/splash_screen.dart';

import '../presentation/pages/home_page/home_page.dart';

class Routes {
  GoRouter routerConfig = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: '/defined',
        name: 'category',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: DefinedCategoryPage(
            tag: state.extra as String,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          key: state.pageKey,
        ),
      ),
    ],
  );
}
