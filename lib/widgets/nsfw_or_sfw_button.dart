import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:restful_solid_bloc/src/presentation/pages/home_page/home_page_imports.dart';
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
      firstChild: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            AppColors.secondaryRed,
          ),
          splashFactory: InkSparkle.splashFactory,
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
        onPressed: _toggleNSFW,
        child: Row(
          children: [
            SizedBox(
              width: 35,
              height: 35,
              child: Image.asset(
                'assets/images/icons/remICON.png',
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'Now you will fetch NSFW',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
          ],
        ),
      ),
      secondChild: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.primary),
          padding: WidgetStateProperty.all(
            EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
        onPressed: _toggleNSFW,
        child: Row(
          children: [
            SizedBox(
              width: 35,
              height: 35,
              child: Image.asset(
                'assets/images/icons/ramICON.png',
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'Now you will fetch SFW',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
            ),
          ],
        ),
      ),
      crossFadeState:
          isNSFW ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: duration,
    );
  }
}
