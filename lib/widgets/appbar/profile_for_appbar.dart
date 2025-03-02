import 'package:flutter/material.dart';
import '../../src/theme/app_colors.dart';
import '../../src/constants/ui_constants.dart';

class AvatarProfile extends StatelessWidget {
  const AvatarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: UIConstants.avatarSize,
          height: UIConstants.avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(UIConstants.alphaHigh),
                blurRadius: UIConstants.shadowBlurRadius,
                offset: const Offset(0, UIConstants.shadowOffsetY),
              ),
            ],
            gradient: AppColors.secondaryGradient,
            border: Border.all(
              color: Colors.white,
              width: UIConstants.borderWidthLarge,
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            width: UIConstants.notificationBadgeSize,
            height: UIConstants.notificationBadgeSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(25),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
              gradient: AppColors.secondaryGradient,
              border: Border.all(
                color: Colors.white,
                width: UIConstants.borderWidthMedium,
              ),
            ),
            child: Center(
              child: Text(
                '3',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.accentDark,
                      fontSize: 10,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
