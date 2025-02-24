import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/home_page_cubit/cubit/anime_pics_cubit.dart';
import 'package:restful_solid_bloc/widgets/amount_tab_bar_picker.dart';
import 'package:restful_solid_bloc/widgets/custom_appbar.dart';
import 'package:restful_solid_bloc/widgets/custom_drawer/my_custom_drawer.dart';
import 'package:restful_solid_bloc/widgets/custom_loading_circle.dart';
import 'package:restful_solid_bloc/widgets/image_card/image_card.dart';
import 'package:restful_solid_bloc/widgets/nsfw_sfw_row_fab.dart';

import '../../../domain/anime_tags.dart';

class DefinedCategoryPage extends StatelessWidget {
  const DefinedCategoryPage({super.key, required this.tags});
  final List<String> tags;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AnimePicsCubit>(context)..clearState();
    return Scaffold(
      floatingActionButton: NsfwSfwRowFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: CustomAppbar(
        title: '$tags',
        actions: [
          ElevatedButton(
            onPressed: () {
              GetIt.I<IAnimeTags>().clearTags();
            },
            child: Text(
              'clear tag\'s',
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
        titleStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: const MyCustomDrawer(),
      body: Column(
        children: [
          AmountTabBar(
            bloc: bloc,
            tags: tags,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome to the Horny Anime App!',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                BlocBuilder<AnimePicsCubit, AnimePicsState>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is AnimePictureState) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(
                            25,
                          ),
                        ),
                        child: ImageCard(
                          imageUrl: state.pictureUrl,
                          date: state.uploadedAt,
                          source: state.source,
                        ),
                      );
                    } else if (state is AnimeMultiplePicturesState) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(
                            25,
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.6 +
                              MediaQuery.of(context).padding.bottom,
                          child: ListView.builder(
                            itemCount: state.pictureUrls.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return ImageCard(
                                imageUrl: state.pictureUrls[index],
                                date: state.uploadedAt[index],
                                source: state.source[index],
                              );
                            },
                          ),
                        ),
                      );
                    } else if (state is AnimePictureError) {
                      return Column(
                        children: [
                          Text(
                            'Problem was caught.',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: Colors.red,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Try to clear tag\'s, add tag\'s by one per time, sometimes base doesnt have multiple tag\'s like \n "Maid + Gif + Oppai"',
                              maxLines: 3,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          ExpansionTile(
                            leading: Icon(
                              Icons.error,
                            ),
                            iconColor: Theme.of(context).colorScheme.error,
                            title: Text(
                              'See full error code',
                            ),
                            children: [
                              Text(
                                state.message,
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (state is AnimePicsLoading) {
                      return const CustomLoadingCircle(
                        size: 100.0,
                      );
                    }
                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(
                            25,
                          ),
                        ),
                        child: Text(
                          'Be carefull! This is a NSFW content!',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
