import 'home_page_imports.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AnimePicsCubit>(context);
    return Scaffold(
      floatingActionButton: NsfwSfwRowFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: CustomAppbar(
        title: 'Home Page',
        actions: [
          ElevatedButton(
            onPressed: () {
              GetIt.I<IAnimeTags>().clearTags();
            },
            child: Text(
              'remove tag\'s',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
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
          AmountTabBar(bloc: bloc),
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
                    return ReminderAboutNsfw();
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
