import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restful_solid_bloc/src/data/constants.dart';
import 'package:restful_solid_bloc/src/data/repositories/data_anime_repo.dart';
import 'package:restful_solid_bloc/src/data/repositories/quotes_repo.dart';
import 'package:restful_solid_bloc/src/domain/anime_tags.dart';
import 'package:restful_solid_bloc/src/domain/url_service.dart';

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
    getIt.registerLazySingleton<IUrlService>(
      () => UrlServiceImpl(),
    );

    getIt.registerLazySingleton<QuotesRepository>(
      () => QuotesRepositoryImpl(
        baseUrl: getIt<Constants>().quotesFetchUrl,
      ),
    );
    getIt.registerLazySingleton<IAnimeRepository>(
      () => Rule34AnimeRepository(
        baseUrl: getIt<Constants>().rule34Api,
      ),
      instanceName: 'rule34Repository',
    );
    getIt.registerLazySingleton<IAnimeRepository>(
      () => DataAnimeRepository(
        baseUrl: getIt<Constants>().animeFetchUrl,
      ),
      instanceName: 'waifuRepository',
    );
  }
}
