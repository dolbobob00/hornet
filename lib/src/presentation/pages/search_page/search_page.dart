// SearchField
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/home_page_cubit/cubit/anime_pics_cubit.dart';
import 'package:restful_solid_bloc/widgets/custom_appbar.dart';
import 'package:restful_solid_bloc/widgets/custom_drawer/my_custom_drawer.dart';
import 'package:restful_solid_bloc/widgets/custom_loading_circle.dart';
import 'package:restful_solid_bloc/widgets/image_card/image_card.dart';
import 'package:restful_solid_bloc/widgets/nsfw_sfw_row_fab.dart';
import 'package:restful_solid_bloc/widgets/search_field/search_field.dart';

import '../../../../widgets/image_card/media_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AnimePicsCubit>(context)..clearState();
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Try to search for your waifu',
        titleStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: const MyCustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchField(),
            ),
            ExpansionTile(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Rules of tag writing',
                  ),
                  Icon(
                    Icons.info,
                  ),
                ],
              ),
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: '- It\'s better to start with small letter\n',
                          ),
                          TextSpan(
                            text:
                                '- Use underscope "_" and not use space " "\n',
                          ),
                          TextSpan(
                            text:
                                '- Sometimes you must use name and surname of character\n',
                          ),
                          TextSpan(
                            text:
                                'Something like: "zoro_roronoa" or "dayneris_targaryen"\n',
                          ),
                          TextSpan(
                            text:
                                '- Sometimes you must specify name of which anime talking\n',
                          ),
                          TextSpan(
                            text:
                                'Something like: "rem_(re:zero)" and "ram_(re:zero)"\n',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
                        if (state.pictureUrls.isEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                Text(
                                  'Try to fetch again please',
                                ),
                                Text(
                                  'Sometimes there is problem with pagination of r34...',
                                ),
                                CustomLoadingCircle(),
                              ],
                            ),
                          );
                        }
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
      ),
    );
  }
}
