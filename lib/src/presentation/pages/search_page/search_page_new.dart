import '../home_page/home_page_imports.dart';
import 'search_page_imports.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AnimePicsCubit>(context)..clearState();
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Try to search for your waifu',
        titleStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return PageCounterModal();
            },
          );
        },
        child: Icon(
          Icons.pages,
        ),
      ),
      drawer: const MyCustomDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SearchField(),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: MyCustomCard(
                  child: ExpansionTileRules(),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: MyCustomCard(
                    child: Text(
                      'Search for you\'r waifu',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
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
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
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
                          InkWell(
                            borderRadius: BorderRadius.circular(32),
                            onTap: () {},
                            child: ContinueAt(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
