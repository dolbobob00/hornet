import 'package:flutter/material.dart';
import 'package:restful_solid_bloc/src/theme/app_colors.dart';

class NameText extends StatelessWidget {
  const NameText({super.key, this.subtitle, this.title});
  final String? title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 2,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle ?? 'Stay trending!',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.secondaryGray,
                ),
          ),
          Text(
            title ?? 'Boris Stankov',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.primaryBlack,
                ),
          ),
        ],
      ),
    );
  }
}
