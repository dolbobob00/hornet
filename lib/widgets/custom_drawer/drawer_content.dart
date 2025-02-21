import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/anime_categories_info/cubit/anime_info_cubit.dart';
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
                  onPressed: () => context.read<AnimeInfoCubit>().fetchCategories(),
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
              ...state.animeCategories.entries.map(
                (entry) => _buildCategoryTile(entry),
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildCategoryTile(MapEntry<String, dynamic> entry) {
    return ExpansionTile(
      leading: const Icon(Icons.category),
      title: Text(entry.key),
      children: (entry.value as List).map<Widget>(
        (item) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
          ),
          child: DrawerListTile(
            name: _capitalizeFirstLetter(item['name'].toString()),
            description: item['description'],
          ),
        ),
      ).toList(),
    );
  }

  String _capitalizeFirstLetter(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }
}
