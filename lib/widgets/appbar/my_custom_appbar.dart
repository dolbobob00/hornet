import 'package:flutter/material.dart';
import '../../src/theme/app_colors.dart';
import '../../src/theme/ui_constants.dart';

class MyCustomAppbar extends StatelessWidget {
  const MyCustomAppbar({super.key, this.title, this.actions, this.leading});
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: AppColors.transparent,
      centerTitle: false,
      leadingWidth: UIConstants.avatarSize * 2,
      leading: Container(),
      toolbarHeight: MediaQuery.of(context).size.height * UIConstants.appBarHeightMultiplier,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.0,
        centerTitle: true,
        title: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: UIConstants.paddingLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (leading != null) leading!,
                if (title != null) Expanded(child: title!),
                if (actions != null)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: actions!,
                  ), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
