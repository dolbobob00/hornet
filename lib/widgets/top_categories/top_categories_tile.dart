import 'package:flutter/material.dart';
import 'package:restful_solid_bloc/src/presentation/pages/splash_screen/splash_screen_imports.dart';
import 'package:restful_solid_bloc/src/theme/app_colors.dart';

class TopCategoriesTile extends StatelessWidget {
  const TopCategoriesTile({super.key, required this.url, this.text});
  final String? text;
  final String url;
  String _capitalizeFirstLetter(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (text != null) {
          context.pushNamed(
            'category',
            extra: _capitalizeFirstLetter(
              text!,
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryWhite,
                  width: 3,
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://avatars.mds.yandex.net/get-mpic/1704691/img_id9000352014314714834.jpeg/orig'),
                ),
              ),
            ),
            Text(
              text ?? 'Unknown',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.primaryWhite, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
