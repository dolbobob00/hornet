import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/anime_categories_info/cubit/anime_info_cubit.dart';
import 'package:restful_solid_bloc/widgets/home_page_related/listview/listview_tile.dart';

class ListViewForApp extends StatelessWidget {
  const ListViewForApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeInfoCubit, AnimeInfoState>(
      builder: (context, state) {
        if (state is AnimeInfoLoaded) {
          return ListView.builder(
            itemCount: state.categoriesList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListViewTile(
                  title: state.categoriesList[index]['name'],
                  subtitle: state.categoriesList[index]["description"],
                  imageUrl: state.imagesUrl[index],
                ),
              );
            },
          );
        }
        return ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListViewTile(
                title: 'LOVE REM',
                subtitle: 'LETS ALL LOVE REM',
              ),
            );
          },
        );
      },
    );
  }
}
