import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:restful_solid_bloc/src/theme/app_colors.dart';
import 'package:restful_solid_bloc/widgets/custom_loading_circle.dart';

import '../../../src/theme/ui_constants.dart';

class AllCategoriesCircleTile extends StatelessWidget {
  const AllCategoriesCircleTile({super.key, required this.url, this.text});
  final String? text;
  final String url;

  static const String _fallbackImageUrl =
      'https://avatars.mds.yandex.net/i?id=421d7fb22377db0d3ffedb433027eaa97969920f-8391913-images-thumbs&ref=rim&n=33&w=444&h=250';

  String _capitalizeFirstLetter(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (text != null) {
          context.pushReplacementNamed(
            'category',
            extra: {
              'tag': _capitalizeFirstLetter(
                text!,
              ),
              'isCheckLast': false,
            },
          );
        }
      },
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: UIConstants.paddingSmall),
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
                  width: UIConstants.borderWidthMedium,
                ),
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: url.isNotEmpty ? url : _fallbackImageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CustomLoadingCircle(size: 20),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
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
