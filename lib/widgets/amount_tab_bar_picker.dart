import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:restful_solid_bloc/src/domain/anime_tags.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/home_page_cubit/cubit/anime_pics_cubit.dart';
import 'package:restful_solid_bloc/widgets/my_custom_card.dart';

// ignore: must_be_immutable
class AmountTabBar extends StatefulWidget {
  const AmountTabBar({super.key, required this.bloc, this.tags});
  final AnimePicsCubit bloc;
  final List<String>? tags;
  @override
  State<AmountTabBar> createState() => _AmountTabBarState();
}

class _AmountTabBarState extends State<AmountTabBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyCustomCard(
          child: Text(
            'Fetch that amount of pictures: ',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                widget.bloc.fetchMultiplePictures(
                  isNsfw: GetIt.I<IAnimeTags>().showNSFW,
                  isGif: GetIt.I<IAnimeTags>().showGif,
                  amount: 5,
                  tags: widget.tags,
                );
              },
              child: Text(
                '5-pics',
                style: MediaQuery.of(context).size.width > 600
                    ? Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        )
                    : Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.bloc.fetchMultiplePictures(
                  isNsfw: GetIt.I<IAnimeTags>().showNSFW,
                  isGif: GetIt.I<IAnimeTags>().showGif,
                  amount: 10,
                  tags: widget.tags,
                );
              },
              child: Text(
                '10-pics',
                style: MediaQuery.of(context).size.width > 600
                    ? Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        )
                    : Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.bloc.fetchMultiplePictures(
                  isNsfw: GetIt.I<IAnimeTags>().showNSFW,
                  isGif: GetIt.I<IAnimeTags>().showGif,
                  amount: 15,
                  tags: widget.tags,
                );
              },
              child: Text(
                '15-pics',
                style: MediaQuery.of(context).size.width > 600
                    ? Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        )
                    : Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
              ),
            ),
            Column(
              children: [
                MyCustomCard(
                  child: Text(
                    'Show gif?',
                    style: MediaQuery.of(context).size.width > 600
                        ? Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            )
                        : Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                  ),
                ),
                Switch.adaptive(
                  value: GetIt.I<IAnimeTags>().showGif,
                  onChanged: (value) {
                    setState(
                      () {
                        GetIt.I<IAnimeTags>().changeShowGif = value;
                      },
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
