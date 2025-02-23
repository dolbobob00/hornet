import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:restful_solid_bloc/src/domain/anime_tags.dart';
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
          pageBuilder: (context, state) {
            final extra = state.extra as String;
            GetIt.I<IAnimeTags>().addTag(
              tag: extra,
            );
            return CustomTransitionPage(
              child: DefinedCategoryPage(
                tags: GetIt.I<IAnimeTags>().tags,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              key: state.pageKey,
            );
          }),
    ],
  );
}
