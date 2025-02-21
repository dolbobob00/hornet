import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/anime_categories_info/cubit/anime_info_cubit.dart';
import 'drawer_content.dart';

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<AnimeInfoCubit>(),
      child: const Drawer(
        child: DrawerContent(),
      ),
    );
  }
}