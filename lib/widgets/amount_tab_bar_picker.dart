import 'package:flutter/material.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/home_page_cubit/cubit/anime_pics_cubit.dart';

// ignore: must_be_immutable
class AmountTabBar extends StatefulWidget {
  const AmountTabBar({super.key, required this.bloc, this.tags});
  final AnimePicsCubit bloc;
  final List<String>? tags;
  @override
  State<AmountTabBar> createState() => _AmountTabBarState();
}

class _AmountTabBarState extends State<AmountTabBar> {
  bool showGif = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Fetch that amount of pictures: '),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                widget.bloc.fetchMultiplePictures(
                  isNsfw: true,
                  isGif: showGif,
                  amount: 5,
                  tags: widget.tags,
                );
              },
              child: Text(
                '5-pics',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.bloc.fetchMultiplePictures(
                  isNsfw: true,
                  isGif: showGif,
                  amount: 10,
                  tags: widget.tags,
                );
              },
              child: Text(
                '10-pics',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.bloc.fetchMultiplePictures(
                  isNsfw: true,
                  isGif: showGif,
                  amount: 15,
                  tags: widget.tags,
                );
              },
              child: Text(
                '15-pics',
              ),
            ),
            Column(
              children: [
                Text(
                  'Show gif?',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.grey,
                  ),
                ),
                Switch.adaptive(
                  value: showGif,
                  onChanged: (value) {
                    setState(
                      () {
                        showGif = value;
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
