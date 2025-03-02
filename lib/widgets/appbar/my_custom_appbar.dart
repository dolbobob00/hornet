import 'package:flutter/material.dart';
import '../../src/theme/app_colors.dart';
import '../search_field/search_field.dart';

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
      leadingWidth: 100,
      leading: Container(),
      toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1.0,
        centerTitle: true,
        title: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
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
