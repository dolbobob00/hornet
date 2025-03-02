import 'package:flutter/material.dart';
import 'package:restful_solid_bloc/src/theme/app_colors.dart';
import 'package:restful_solid_bloc/widgets/custom_icon.dart';

class ContinueAt extends StatelessWidget {
  const ContinueAt({super.key, this.url, this.name});
  final String? url;
  final String? name;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: AppColors.primaryWhite,
        border: Border.all(),
        borderRadius: BorderRadius.circular(
          60,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CircleAvatar(
                  radius: 25,
                  foregroundImage: NetworkImage(
                    url ??
                        'https://i.pinimg.com/originals/5e/1b/80/5e1b8054879243108737cdf7b1985922.jpg',
                  ),
                ),
              ),
              Text(
                name ?? 'Nah id win',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: AppColors.primaryBlack),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomIcon(
              icon: Icons.play_arrow,
              color: AppColors.primaryBlack,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
