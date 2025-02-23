import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:restful_solid_bloc/src/data/repositories/data_anime_repo.dart';
part 'anime_pics_state.dart';

class AnimePicsCubit extends Cubit<AnimePicsState> {
  AnimePicsCubit() : super(AnimePicsInitial());
  final IAnimeRepository repository = GetIt.I<IAnimeRepository>();

  void clearState() {
    emit(
      AnimePicsInitial(),
    );
  }

  void fetchMultiplePictures({
    required bool isNsfw,
    required bool isGif,
    required int amount,
    List<String>? tags,
  }) async {
    emit(
      AnimePicsLoading(),
    );

    try {
      final responce = await repository.getAnimeMedia(
        isNsfw: isNsfw,
        isGif: isGif,
        amount: amount,
        tags: tags,
      );
      final List<dynamic> images = responce.entries.first.value;
      final List<String> pictureUrls = [];
      final List<String> uploadedAt = [];
      final List<String> source = [];
      for (var element in images) {
        final String? pictureUrl = element['url'];
        final String? uploaded = element['uploaded_at'];
        final String? sourceAuthor = element['source'];
        pictureUrls.add(pictureUrl ?? '');
        uploadedAt.add(uploaded ?? 'Unknown');
        source.add(sourceAuthor ?? 'Unknown');
      }
      emit(
        AnimeMultiplePicturesState(
          pictureUrls: pictureUrls,
          uploadedAt: uploadedAt,
          source: source,
        ),
      );
    } catch (e) {
      emit(
        AnimePictureError(
          message: 'Failed to fetch picture $e',
        ),
      );
    }
  }

  void fetchOnePicture({
    required bool isNsfw,
    required bool isGif,
    List<String>? tag,
  }) async {
    emit(AnimePicsLoading());

    try {
      final response = await repository.getAnimeMedia(
        isNsfw: isNsfw,
        isGif: isGif,
        amount: 2,
        tags: tag?.isNotEmpty == true ? tag : null, // Only pass tags if not empty
      );
      
      final responseInfo = response['images'] ?? []; // Use proper key from API
      if (responseInfo.isEmpty) {
        throw Exception('No images found');
      }

      final imageData = responseInfo[0];
      emit(AnimePictureState(
        pictureUrl: imageData['url'] ?? 'fallback_url',
        uploadedAt: imageData['uploaded_at'] ?? 'Unknown',
        source: imageData['source'] ?? 'Unknown',
      ));
    } catch (e) {
      emit(AnimePictureError(
        message: 'Failed to fetch picture: ${e.toString()}',
      ));
    }
  }
}
