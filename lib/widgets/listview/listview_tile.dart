import 'package:flutter/material.dart';
import 'package:restful_solid_bloc/src/theme/app_colors.dart';

class ListViewTile extends StatelessWidget {
  const ListViewTile({super.key, this.imageUrl, this.subtitle, this.title});
  final String? imageUrl;
  final String? title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 187,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  imageUrl ??
                      'https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/80e2b6ff-b910-44bc-b34b-1048a603cf05/1920x',
                ),
                fit: BoxFit.cover,
              ),
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(
                16,
              ),
            ),
          ),
          Text(
            title ?? '',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: AppColors.primaryBlack,
                ),
          ),
          Text(
            subtitle ?? '',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.secondaryGray,
                ),
          ),
        ],
      ),
    );
  }
}
