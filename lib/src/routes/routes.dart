import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:restful_solid_bloc/src/domain/anime_tags.dart';
import 'package:restful_solid_bloc/src/presentation/pages/defined_category/defined_category_page.dart';
import 'package:restful_solid_bloc/src/presentation/pages/splash_screen/splash_screen.dart';
import 'package:restful_solid_bloc/widgets/anime_card/fullscreen_image/fullscreen_image_view.dart';

import '../presentation/pages/home_page/home_page.dart';
import '../presentation/pages/random_page/random_anime_page.dart';
import '../presentation/pages/search_page/search_page.dart';

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
          child: HomePage(),
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
        path: '/random',
        name: 'random',
        pageBuilder: (context, state) => CustomTransitionPage(
          child: RandomAnimePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            GetIt.I<IAnimeTags>().clearTags();
            // Slide transition from right
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
          final extra = state.extra as Map<String, dynamic>;
          if ((extra['isCheckLast'] ?? false) == true) {
            GetIt.I<IAnimeTags>().clearTags();
            GetIt.I<IAnimeTags>().changeAllTagsTo =
                (extra['tag'] as String).split(
              ' ',
            );
          } else {
            GetIt.I<IAnimeTags>().addTag(
              tag: extra['tag']?.toString() ?? '',
            );
          }
          GetIt.I<IAnimeTags>().setLastTag = {
            'tag': GetIt.I<IAnimeTags>().tags.join(' '),
            'route': 'category',
          };
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
