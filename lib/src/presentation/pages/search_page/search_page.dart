import 'package:restful_solid_bloc/widgets/my_custom_card.dart';

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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
