import 'defined_category_imports.dart';

class DefinedCategoryPage extends StatelessWidget {
  const DefinedCategoryPage({super.key, required this.tags});
  final List<String> tags;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AnimePicsCubit>(context)..clearState();
    return Scaffold(
      floatingActionButton: NsfwSfwRowFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: CustomAppbar(
        title: '$tags',
        actions: [
          ElevatedButton(
            onPressed: () {
              GetIt.I<IAnimeTags>().clearTags();
            },
            child: Text(
              'clear tag\'s',
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
        titleStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawer: const MyCustomDrawer(),
      body: Column(
        children: [
          AmountTabBar(
            bloc: bloc,
            tags: tags,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  tags.join(),
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                BlocBuilder<AnimePicsCubit, AnimePicsState>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is AnimePictureState) {
                      return AnimePictureSingle(
                          pictureUrl: state.pictureUrl,
                          uploadedAt: state.uploadedAt,
                          source: state.source);
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
                    return const ReminderAboutNsfw();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
