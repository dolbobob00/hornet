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
                  foregroundImage: NetworkImage(url ??
                      'https://steamuserimages-a.akamaihd.net/ugc/187291001665850410/70264D31640E4F5D80F2B27B4AFBE076AE0F9AE2/?imw=512&amp;imh=287&amp;ima=fit&amp;impolicy=Letterbox&amp;imcolor=%23000000&amp;letterbox=true'),
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
