import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/anime_categories_info/cubit/anime_info_cubit.dart';
import 'package:restful_solid_bloc/widgets/home_page_related/top_categories/all_categories_circle_tile.dart';

class AllCategoriesCircleBuilder extends StatelessWidget {
  const AllCategoriesCircleBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeInfoCubit, AnimeInfoState>(
      builder: (context, state) {
        if (state is AnimeInfoLoaded) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.15,
            child: ListView.builder(
              padding: EdgeInsets.only(
                left: 32,
                right: 32,
                top: 12,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: state.categoriesList.length,
              itemBuilder: (context, index) => AllCategoriesCircleTile(
                url: state.imagesUrl[index],
                text: state.categoriesList[index]['name'],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
