import 'package:restful_solid_bloc/src/theme/app_colors.dart';
import 'package:restful_solid_bloc/widgets/animations/animated_icon.dart';

import '../../../../widgets/appbar/my_custom_appbar.dart';
import '../../../../widgets/appbar/name_text.dart';
import 'defined_category_imports.dart';

class DefinedCategoryPage extends StatelessWidget {
  const DefinedCategoryPage({super.key, required this.tags});
  final List<String> tags;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AnimePicsCubit>();
    return Scaffold(
      drawer: MyCustomDrawer(),
      backgroundColor: AppColors.primaryWhite,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MyCustomAppbar(
            leading: CircleAvatar(
              backgroundImage: const AssetImage(
                'assets/images/background/splashBG.jpg',
              ),
              radius: 24,
            ),
            title: Align(
              alignment: Alignment.centerLeft,
              child: NameText(
                title: '$tags',
                subtitle: 'Take a joy!',
              ),
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    BlocBuilder<AnimePicsCubit, AnimePicsState>(
                      bloc: bloc,
                      builder: (context, state) {
                        if (state is AnimePictureState) {
                          return AnimePictureSingle(
                            pictureUrl: state.pictureUrl,
                            uploadedAt: state.uploadedAt,
                            source: state.source,
                          );
                        } else if (state is AnimeMultiplePicturesState) {
                          if (state.pictureUrls.isEmpty) {
                            return const Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Try to fetch again please',
                                  ),
                                  Text(
                                    'Maybe problems somehow.',
                                  ),
                                  CustomLoadingCircle(),
                                ],
                              ),
                            );
                          }
                          return AnimePicturesMultiple(
                            pictureUrls: state.pictureUrls,
                            uploadedAt: state.uploadedAt,
                            source: state.source,
                          );
                        } else if (state is AnimePictureError) {
                          return ErrorHandlerAnimePictures(
                            message: state.message,
                          );
                        } else if (state is AnimePicsLoading) {
                          return const CustomLoadingCircle(
                            size: 100.0,
                          );
                        }
                        return const ReminderAboutNsfw();
                      },
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2 + 30,
                decoration: BoxDecoration(
                  gradient: AppColors.secondaryGradient,
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
                      padding:
                          const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                      child: Divider(
                        color: AppColors.background,
                        endIndent: MediaQuery.of(context).size.width * 0.4,
                        indent: MediaQuery.of(context).size.width * 0.4,
                        height: 3,
                        thickness: 2,
                      ),
                    ),
                    AmountTabBar(
                      bloc: bloc,
                      tags: tags,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: NsfwSfwRowFab(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
