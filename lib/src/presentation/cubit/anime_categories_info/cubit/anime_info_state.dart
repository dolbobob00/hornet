part of 'anime_info_cubit.dart';

@immutable
sealed class AnimeInfoState {}

final class AnimeInfoInitial extends AnimeInfoState {}

final class AnimeInfoError extends AnimeInfoState {
  final String message;
  AnimeInfoError({required this.message});
}

final class AnimeInfoLoading extends AnimeInfoState {}

final class AnimeInfoLoaded extends AnimeInfoState {
  final Map<String, dynamic> animeCategories;
   final List<dynamic> categoriesList;
  AnimeInfoLoaded({required this.animeCategories,required this.categoriesList});
}
