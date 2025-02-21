part of 'anime_pics_cubit.dart';

@immutable
sealed class AnimePicsState {}

final class AnimePicsInitial extends AnimePicsState {}

final class AnimePicsLoading extends AnimePicsState {}

final class AnimePictureState extends AnimePicsState {
  final String pictureUrl;
  final String uploadedAt;

  final String? previewUrl;
  final String source;
  AnimePictureState({
    required this.source,
    required this.uploadedAt,
    required this.pictureUrl,
    this.previewUrl,
  });
}

final class AnimePictureError extends AnimePicsState {
  final String message;

  AnimePictureError({
    required this.message,
  });
}

final class AnimeMultiplePicturesState extends AnimePicsState{
  final List<String> pictureUrls;
  final List<String> uploadedAt;
  final List<String> source;

  AnimeMultiplePicturesState(
      {required this.pictureUrls,
      required this.uploadedAt,
      required this.source});
}
