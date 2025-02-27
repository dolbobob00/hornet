import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../src/domain/anime_tags.dart';
class NsfwSfwRowFab extends StatefulWidget {
  const NsfwSfwRowFab({super.key});

  @override
  State<NsfwSfwRowFab> createState() => _NsfwSfwRowFabState();
}

class _NsfwSfwRowFabState extends State<NsfwSfwRowFab> {
  bool isNSFW = GetIt.I<IAnimeTags>().showNSFW;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: [
        FloatingActionButton(
          backgroundColor: isNSFW ? Colors.green : Colors.red,
          onPressed: () {
            try {
              GetIt.I<IAnimeTags>().changeShowNSFW = true;
              setState(() {
                isNSFW = true;
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    e.toString(),
                  ),
                ),
              );
            }
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
          backgroundColor: isNSFW ? Colors.red : Colors.green,
          onPressed: () {
            try {
              setState(() {
                isNSFW = false;
              });
              GetIt.I<IAnimeTags>().changeShowNSFW = false;
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    e.toString(),
                  ),
                ),
              );
            }
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
