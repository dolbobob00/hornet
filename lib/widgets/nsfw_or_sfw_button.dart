import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../src/domain/anime_tags.dart';

class NsfwSfwRowFab extends StatefulWidget {
  const NsfwSfwRowFab({super.key});

  @override
  State<NsfwSfwRowFab> createState() => _NsfwSfwRowFabState();
}

class _NsfwSfwRowFabState extends State<NsfwSfwRowFab> {
  late bool isNSFW;
  final Duration duration = const Duration(milliseconds: 250);

  @override
  void initState() {
    super.initState();
    isNSFW = GetIt.I<IAnimeTags>().showNSFW;
  }

  void _toggleNSFW() {
    try {
      setState(() {
        isNSFW = !isNSFW;
        GetIt.I<IAnimeTags>().changeShowNSFW = isNSFW;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: FloatingActionButton(
        onPressed: _toggleNSFW,
        heroTag: 'btn3',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.image),
            Text(
              'NSFW\n now',
              style: const TextStyle(
                fontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
      secondChild: FloatingActionButton(
        onPressed: _toggleNSFW,
        heroTag: 'btn4',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.image),
            Text(
              'SFW \nnow',
              style: const TextStyle(
                fontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
      crossFadeState:
          isNSFW ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: duration,
    );
  }
}
