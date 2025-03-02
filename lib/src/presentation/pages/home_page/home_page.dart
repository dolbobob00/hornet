import 'package:restful_solid_bloc/widgets/my_custom_card.dart';

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
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background/bg2.jpg',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            children: [
              AmountTabBar(bloc: bloc),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyCustomCard(
                      child: Text(
                        'Welcome to the Horny Anime App!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 20,
                            ),
                      ),
                    ),
                 const   SizedBox(height: 20),
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
            ],
          ),
        ],
      ),
    );
  }
}
