import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/anime_categories_info/cubit/anime_info_cubit.dart';
import 'package:restful_solid_bloc/widgets/top_categories/top_categories_tile.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeInfoCubit, AnimeInfoState>(
      builder: (context, state) {
        if (state is AnimeInfoLoaded) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              padding: EdgeInsets.only(
                left: 32,
                right: 32,
                top: 12,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: state.categoriesList.length,
              itemBuilder: (context, index) => TopCategoriesTile(
                url:
                    'https://avatars.mds.yandex.net/i?id=421d7fb22377db0d3ffedb433027eaa97969920f-8391913-images-thumbs&ref=rim&n=33&w=444&h=250',
                text: state.categoriesList[index]['name'],
              ),
            ),
          );
          // ...state.animeCategories.entries.map(
          //     (entry) => CategoryTile(
          //       entry: entry,
          //     ),
          //   ),
        }
        return Container();
      },
    );
  }
}
