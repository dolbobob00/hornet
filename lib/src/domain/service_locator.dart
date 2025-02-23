import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restful_solid_bloc/src/data/constants.dart';
import 'package:restful_solid_bloc/src/data/repositories/data_anime_repo.dart';
import 'package:restful_solid_bloc/src/data/repositories/quotes_repo.dart';
import 'package:restful_solid_bloc/src/domain/anime_tags.dart';
import 'package:restful_solid_bloc/src/domain/downloader.dart';

abstract class IServiceLocator {
  void getItSetup();
}

class GetItServiceLocator implements IServiceLocator {
  final GetIt getIt = GetIt.instance;

  @override
  void getItSetup() {
    getIt.registerSingleton<Constants>(
      Constants(),
    );
    getIt.registerLazySingleton<Dio>(
      () => Dio(),
    );
    getIt.registerLazySingleton<IAnimeTags>(
      () => AnimeTagsImpl(),
    );
    getIt.registerLazySingleton<IDownloader>(
      () => FileDownloaderImpl(),
    );
    getIt.registerLazySingleton<IAnimeRepository>(
      () => DataAnimeRepository(
        baseUrl: getIt<Constants>().animeFetchUrl,
      ),
    );
    getIt.registerLazySingleton<QuotesRepository>(
      () => QuotesRepositoryImpl(
        baseUrl: getIt<Constants>().quotesFetchUrl,
      ),
    );
  }
}
