import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:restful_solid_bloc/src/domain/anime_tags.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/home_page_cubit/cubit/anime_pics_cubit.dart';

import 'package:restful_solid_bloc/widgets/image_card/image_card.dart';
import 'package:restful_solid_bloc/widgets/amount_tab_bar_picker.dart';

import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_drawer/my_custom_drawer.dart';
import '../../../../widgets/custom_loading_circle.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AnimePicsCubit>(context);
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Home Page',
        actions: [
          ElevatedButton(
            onPressed: () {
              GetIt.I<AnimeTagsImpl>().clearTags();
            },
            child: Text(
              'remove tag\'s',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
        titleStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: const MyCustomDrawer(),
      body: Stack(
        children: [
          AmountTabBar(bloc: bloc),
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
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: ListView.builder(
                            itemCount: state.pictureUrls.length,
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
                      return Text(state.message);
                    } else if (state is AnimePicsLoading) {
                      return const CustomLoadingCircle(
                        size: 100.0,
                      );
                    }
                    return Container(
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
                    );
                  },
                )
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    heroTag: 'btn1',
                    onPressed: () {
                      try {
                        bloc.fetchOnePicture(
                          isNsfw: true,
                          isGif: true,
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Icon(Icons.gif),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton(
                    heroTag: 'btn2',
                    onPressed: () {
                      try {
                        bloc.fetchOnePicture(
                          isNsfw: true,
                          isGif: false,
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Icon(Icons.image),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
