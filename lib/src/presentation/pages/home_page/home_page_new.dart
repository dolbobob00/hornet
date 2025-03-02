import 'package:flutter/material.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/animations_cubit/cubit/animations_cubit.dart';
import 'package:restful_solid_bloc/src/presentation/pages/home_page/home_page_imports.dart';
import 'package:restful_solid_bloc/src/presentation/pages/search_page/search_page_imports.dart';
import 'package:restful_solid_bloc/src/theme/app_colors.dart';
import 'package:restful_solid_bloc/src/theme/app_theme.dart';
import 'package:restful_solid_bloc/widgets/animations/animated_icon.dart';
import 'package:restful_solid_bloc/widgets/anime_pictures_view/continue_at.dart';
import 'package:restful_solid_bloc/widgets/appbar/my_custom_appbar.dart';
import 'package:restful_solid_bloc/widgets/appbar/name_text.dart';
import 'package:restful_solid_bloc/widgets/appbar/profile_for_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restful_solid_bloc/widgets/custom_icon.dart';
import 'package:restful_solid_bloc/widgets/listview/listview_for_app.dart';
import 'package:restful_solid_bloc/widgets/search_field/search_on_app.dart';
import 'package:restful_solid_bloc/widgets/top_categories/top_categories.dart';

class HomePageNew extends StatelessWidget {
  const HomePageNew({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: MyCustomDrawer(),
      onDrawerChanged: (isOpened) {
        context.read<AnimationsCubit>().mustProvideAnimation(value: isOpened);
      },
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MyCustomAppbar(
            leading: AvatarProfile(),
            title: Align(
              alignment: Alignment.centerLeft,
              child: NameText(),
            ),
            actions: [
              Align(
                alignment: Alignment(0.5, -0.2),
                child: CustomAnimatedIcon(
                  animIcon: AnimatedIcons.menu_arrow,
                  size: 34,
                  onTap: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ],
          ),
        ],
        body: SafeArea(
          child: SizedBox(
            height: screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchFieldForApp(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26.0,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Must check it',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: AppColors.primaryBlack,
                            ),
                      ),
                      InkWell(
                        splashColor: AppColors.primary,
                        radius: 32,
                        borderRadius: BorderRadius.circular(32),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'When you press at something\n you will be navigated at special place',
                              ),
                            ],
                          )),
                        ),
                        child: CustomIcon(
                          icon: Icons.more_horiz,
                          size: 32,
                          weight: 0.1,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: ListViewForApp(),
                ),
                Flexible(
                  flex: 2,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: AppColors.secondaryGradient,
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              width: 1,
                              color: AppColors.primary,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, left: 16, right: 16),
                              child: Divider(
                                color: AppColors.background,
                                endIndent:
                                    MediaQuery.of(context).size.width * 0.4,
                                indent: MediaQuery.of(context).size.width * 0.4,
                                height: 3,
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 32.0,
                                left: 32,
                                right: 32,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'All Categories',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(color: AppColors.background),
                                  ),
                                  CustomIcon(
                                    icon: Icons.more_horiz,
                                    size: 32,
                                    color: AppColors.background,
                                  ),
                                ],
                              ),
                            ),
                            TopCategories(),
                            Text(
                              'Let\'s all love Rem and Lein...',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary
                                  ),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          gradient: AppColors.secondaryGradientInverse,
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              width: 1,
                              color: AppColors.primaryBlack,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, left: 16, right: 16),
                              child: Divider(
                                color: AppColors.background,
                                endIndent:
                                    MediaQuery.of(context).size.width * 0.4,
                                indent: MediaQuery.of(context).size.width * 0.4,
                                height: 3,
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0, vertical: 8),
                              child: Text(
                                'Continue Watching',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(color: AppColors.background),
                              ),
                            ),
                            ContinueAt(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
