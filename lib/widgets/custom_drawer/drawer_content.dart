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
    return Stack(
      children: [
        BlocBuilder<AnimeInfoCubit, AnimeInfoState>(
          builder: (context, state) {
            if (state is AnimeInfoLoading || state is AnimeInfoInitial) {
              return const Center(
                child: CustomLoadingCircle(),
              );
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
                      child: const Text(
                        'Retry',
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Transform.flip(
                        flipX: true,
                        child: Image.asset(
                          'assets/images/icons/ramICON.png',
                          height: 150,
                          width: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
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
                      context.goNamed(
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
        ),
        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  'assets/images/icons/remICON.png',
                  height: 50,
                  width: 80,
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomLeft,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Transform.flip(
                  flipX: true,
                  child: Image.asset(
                    'assets/images/icons/ramICON.png',
                    height: 50,
                    width: 80,
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomLeft,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
