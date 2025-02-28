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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchField(),
            ),
            ExpansionTileRules(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome to the Horny Anime App!',
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
                          source: state.source,
                        );
                      } else if (state is AnimeMultiplePicturesState) {
                        if (state.pictureUrls.isEmpty) {
                          return Center(
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
                        AnimePicturesMultiple(
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
                     return ReminderAboutNsfw();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
