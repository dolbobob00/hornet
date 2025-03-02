import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../data/repositories/data_anime_repo.dart';

part 'anime_info_state.dart';

class AnimeInfoCubit extends Cubit<AnimeInfoState> {
  AnimeInfoCubit() : super(AnimeInfoInitial());
  final ICategoryRepository repository = GetIt.I<ICategoryRepository>();
  void fetchCategories() async {
    emit(
      AnimeInfoLoading(),
    );
    try {
      final data = await repository.getCategoryAndInfo();
      final categoriesList = (data['versatile'] as List) + (data['nsfw'] as List);
      emit(
        AnimeInfoLoaded(
          categoriesList: categoriesList,
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
