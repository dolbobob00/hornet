import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restful_solid_bloc/src/data/constants.dart';

import '../../../../data/repositories/data_anime_repo.dart';

part 'anime_info_state.dart';

class AnimeInfoCubit extends Cubit<AnimeInfoState> {
  AnimeInfoCubit() : super(AnimeInfoInitial());
  final IAnimeRepository repository =
      DataAnimeRepository(baseUrl: animeFetchUrl);
  void fetchCategories() async {
    emit(
      AnimeInfoLoading(),
    );
    try {
      final data = await repository.getCategoryAndInfo();
      emit(
        AnimeInfoLoaded(
          animeCategories: data,
        ),
      );
    } catch (e) {
      emit(
        AnimeInfoError(
          message: e.toString(),
        ),
      );
    }
  }
}
