import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/animations_cubit/cubit/animations_cubit.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/anime_categories_info/cubit/anime_info_cubit.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/home_page_cubit/cubit/anime_pics_cubit.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/quotes_cubit/cubit/quotes_cubit.dart';

import 'package:restful_solid_bloc/src/routes/routes.dart';
import 'theme/app_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AnimePicsCubit(),
        ),
        BlocProvider(
          create: (context) => AnimeInfoCubit(),
        ),
        BlocProvider(
          create: (context) => QuotesCubit(),
        ),
        BlocProvider(
          create: (context) => AnimationsCubit(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Hornet(Love Rem)',
        routerConfig: Routes.routerConfig,
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
