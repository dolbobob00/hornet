
import 'search_page_imports.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AnimePicsCubit>();
    return Scaffold(
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
                title: 'Search for some NSFW',
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
              SearchField(),
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
                                    'Or change page make it lower.',
                                  ),
                                  Text(
                                    'Or change tag you trying to find.',
                                  ),
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
                          return const Center(
                            child: CustomLoadingCircle(
                              size: 100.0,
                            ),
                          );
                        }
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: MyCustomCard(
                            child: ReminderAboutNsfw(),
                          ),
                        );
                      },
                    ),
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, left: 16, right: 16),
                        child: Divider(
                          color: AppColors.background,
                          endIndent: MediaQuery.of(context).size.width * 0.4,
                          indent: MediaQuery.of(context).size.width * 0.4,
                          height: 3,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return PageCounterModal();
                            },
                          ),
                          child: Text('Change page on which to search'),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: MyCustomCard(
                          child: ExpansionTileRules(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: const MyCustomDrawer(),
    );
  }
}
