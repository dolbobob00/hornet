import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../src/domain/anime_tags.dart';
import '../src/presentation/cubit/home_page_cubit/cubit/anime_pics_cubit.dart';

class NsfwSfwRowFab extends StatelessWidget {
  const NsfwSfwRowFab({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AnimePicsCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        FloatingActionButton(
          onPressed: () {
            bloc.fetchOnePicture(
              isNsfw: true,
              isGif: GetIt.I<IAnimeTags>().showGif,
              tag: GetIt.I<IAnimeTags>().tags,
            );
          },
          heroTag: 'btn3',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.image,
              ),
              Text(
                'NSFW',
                style: TextStyle(
                  fontSize: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            bloc.fetchOnePicture(
              isNsfw: false,
              isGif: GetIt.I<IAnimeTags>().showGif,
              tag: GetIt.I<IAnimeTags>().tags,
            );
          },
          heroTag: 'btn4',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.image,
              ),
              Text(
                'SFW',
                style: TextStyle(
                  fontSize: 10,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
