import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:restful_solid_bloc/src/domain/anime_tags.dart';
import 'package:restful_solid_bloc/src/presentation/pages/search_page/search_page.dart';
import 'package:restful_solid_bloc/src/presentation/pages/secondary_page/defined_category_page.dart';
import 'package:restful_solid_bloc/src/presentation/pages/splash_screen/splash_screen.dart';
import 'package:restful_solid_bloc/widgets/fullscreen_image/fullscreen_image_view.dart';

import '../presentation/pages/home_page/home_page.dart';
import '../presentation/pages/home_page/home_page_new.dart';

class Routes {
  GoRouter routerConfig = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Fade and scale transition for splash screen
            return ScaleTransition(
              scale: animation.drive(
                Tween(begin: 0.0, end: 1.0).chain(
                  CurveTween(curve: Curves.easeInOut),
                ),
              ),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: HomePageNew(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Slide transition from right for home page
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          },
          key: state.pageKey,
        ),
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: SearchPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Fade and scale transition for search page
            return FadeTransition(
              opacity: animation.drive(
                CurveTween(curve: Curves.easeInOut),
              ),
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
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
              // Size and fade transition for category page
              return SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0.0,
                child: FadeTransition(
                  opacity: animation.drive(
                    CurveTween(curve: Curves.easeInOut),
                  ),
                  child: SlideTransition(
                    position: animation.drive(
                      Tween(
                        begin: const Offset(0.0, 1.0),
                        end: Offset.zero,
                      ).chain(CurveTween(curve: Curves.easeInOut)),
                    ),
                    child: child,
                  ),
                ),
              );
            },
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/fullscreen_image',
        name: 'fullscreen_image',
        pageBuilder: (context, state) {
          final extra = state.extra as String;
          return CustomTransitionPage(
            child: FullScreenImageView(
              imageUrl: extra,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Size and fade transition for category page
              return FadeTransition(
                opacity: animation.drive(
                  CurveTween(curve: Curves.easeInOut),
                ),
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              );
            },
            key: state.pageKey,
          );
        },
      ),
    ],
  );
}
