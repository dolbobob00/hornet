import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/anime_categories_info/cubit/anime_info_cubit.dart';
import 'package:restful_solid_bloc/widgets/custom_drawer/category_tile.dart';
import 'package:restful_solid_bloc/widgets/custom_drawer/drawer_header.dart';
import 'package:restful_solid_bloc/widgets/custom_drawer/drawer_list_tile.dart';
import 'package:restful_solid_bloc/widgets/custom_drawer/quotes_section.dart';
import 'package:restful_solid_bloc/widgets/custom_loading_circle.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeInfoCubit, AnimeInfoState>(
      builder: (context, state) {
        if (state is AnimeInfoLoading || state is AnimeInfoInitial) {
          return const Center(child: CustomLoadingCircle());
        }

        if (state is AnimeInfoError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                ElevatedButton(
                  onPressed: () =>
                      context.read<AnimeInfoCubit>().fetchCategories(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is AnimeInfoLoaded) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              const CustomDrawerHeader(),
              const QuotesSection(),
              DrawerListTile(
                name: 'Home',
                description: 'Go to Home Page',
                onTap: () {
                  context.goNamed(
                    'home',
                  );
                },
              ),
              DrawerListTile(
                name: 'Search',
                description: 'Go to Search Page',
                onTap: () {
                  context.pushNamed(
                    'search',
                  );
                },
              ),
              ...state.animeCategories.entries.map(
                (entry) => CategoryTile(
                  entry: entry,
                ),
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
