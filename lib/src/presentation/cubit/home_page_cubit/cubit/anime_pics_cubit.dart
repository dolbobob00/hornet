import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:restful_solid_bloc/src/data/repositories/data_anime_repo.dart';
part 'anime_pics_state.dart';

class AnimePicsCubit extends Cubit<AnimePicsState> {
  AnimePicsCubit() : super(AnimePicsInitial());
  final IAnimeRepository repository = DataAnimeRepository.instance;

  void clearState() {
    emit(
      AnimePicsInitial(),
    );
  }

  void fetchMultiplePictures({
    required bool isNsfw,
    required bool isGif,
    required int amount,
    String? tag,
  }) async {
    emit(
      AnimePicsLoading(),
    );
    if (tag != null) {
      try {
        final responce = await repository.getCategoryPicturesWithAmount(
          isNsfw: isNsfw,
          isGif: isGif,
          amount: amount,
          tag: tag.toLowerCase(),
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
    } else {
      try {
        final responce = await repository.getRandomPicturesWithAmount(
          isNsfw: isNsfw,
          isGif: isGif,
          amount: amount,
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
  }

  void fetchOnePicture(
      {required bool isNsfw, required bool isGif, String? tag}) async {
    emit(
      AnimePicsLoading(),
    );
    if (tag != null) {
      try {
        final responce = await repository.getPictureByParameters(
          isNsfw: true,
          isGif: false,
          naming: tag.toLowerCase(),
        );
        final responceInfo = responce.entries.first.value;
        final String? pictureUrl = responceInfo[0]['url'];
        final String? uploadedAt = responceInfo[0]['uploaded_at'];
        final String? source = responceInfo[0]['source'];
        emit(
          AnimePictureState(
            pictureUrl: pictureUrl ??
                'https://sun9-46.userapi.com/impg/BCmh7rC0xExv7oZtMff-2B8MwfI09gdG1dU_TQ/TxWR5NqwKYw.jpg?size=360x600&quality=96&sign=b174efa120e35c9d79d5c0eb6dab18a0&c_uniq_tag=PT96NrYbjWnlEzaoyM0lwEdvaG_eyhvFWkCEJyQdhDg&type=album',
            uploadedAt: uploadedAt ?? 'Unknown',
            source: source ?? 'Unknown',
          ),
        );
      } catch (e) {
        emit(
          AnimePictureError(
            message: 'Failed to fetch picture $e',
          ),
        );
      }
    } else {
      try {
        final responce = await repository.getPictureByRandom(isNsfw, isGif);
        final responceInfo = responce.entries.first.value;
        final String? pictureUrl = responceInfo[0]['url'];
        final String? uploadedAt = responceInfo[0]['uploaded_at'];
        final String? source = responceInfo[0]['source'];
        emit(
          AnimePictureState(
            pictureUrl: pictureUrl ??
                'https://sun9-46.userapi.com/impg/BCmh7rC0xExv7oZtMff-2B8MwfI09gdG1dU_TQ/TxWR5NqwKYw.jpg?size=360x600&quality=96&sign=b174efa120e35c9d79d5c0eb6dab18a0&c_uniq_tag=PT96NrYbjWnlEzaoyM0lwEdvaG_eyhvFWkCEJyQdhDg&type=album',
            uploadedAt: uploadedAt ?? 'Unknown',
            source: source ?? 'Unknown',
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
  }
}
