import 'package:flutter/material.dart';
import 'package:restful_solid_bloc/src/theme/app_colors.dart';

import '../../../src/theme/ui_constants.dart';

class ListViewTile extends StatelessWidget {
  const ListViewTile({super.key, this.imageUrl, this.subtitle, this.title});
  final String? imageUrl;
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: UIConstants.paddingSmall),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  imageUrl ?? 'https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/80e2b6ff-b910-44bc-b34b-1048a603cf05/1920x',
                ),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(UIConstants.borderRadiusMedium),
            ),
          ),
          const SizedBox(height: UIConstants.paddingSmall),
          if (title != null)
            Flexible(
              child: Text(
                title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.primaryBlack,
                ),
              ),
            ),
          if (subtitle != null)
            Flexible(
              child: Text(
                subtitle!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.secondaryGray,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
