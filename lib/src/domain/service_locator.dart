import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:restful_solid_bloc/src/data/constants.dart';
import 'package:restful_solid_bloc/src/data/repositories/data_anime_repo.dart';
import 'package:restful_solid_bloc/src/data/repositories/quotes_repo.dart';
import 'package:restful_solid_bloc/src/domain/anime_tags.dart';
import 'package:restful_solid_bloc/src/domain/network_client.dart';
import 'package:restful_solid_bloc/src/domain/url_service.dart';

/// Interface for service locator setup
/// Provides a contract for dependency injection configuration
abstract class IServiceLocator {
  void getItSetup();
}

/// Implementation of service locator using GetIt
/// Responsible for registering all dependencies in the application
class GetItServiceLocator implements IServiceLocator {
  final GetIt getIt = GetIt.instance;

  @override
  void getItSetup() {
    // Core dependencies
    // Register constants that are used throughout the app
    getIt.registerSingleton<Constants>(
      Constants(),
    );

    // Network related dependencies
    // Register Dio HTTP client and its wrapper
    getIt.registerSingleton<Dio>(Dio());
    getIt.registerSingleton<INetworkClient>(
      DioNetworkClient(
        GetIt.I<Dio>(),
      ),
    );

    // Domain services
    // Tags service for anime content categorization
    getIt.registerLazySingleton<IAnimeTags>(
      () => AnimeTagsImpl(),
    );
    // URL handling service for external links
    getIt.registerLazySingleton<IUrlService>(
      () => UrlServiceImpl(),
    );

    // Repositories
    // Category repository for fetching anime categories and tags
    getIt.registerLazySingleton<ICategoryRepository>(
      () => CategoryRepository(
        baseUrl: getIt<Constants>().animeFetchUrl,
        networkClient: GetIt.I<INetworkClient>(),
      ),
    );

    // Quotes repository for anime quotes functionality
    getIt.registerLazySingleton<QuotesRepository>(
      () => QuotesRepositoryImpl(
        baseUrl: getIt<Constants>().quotesFetchUrl,
      ),
    );

    // Anime repositories
    // Rule34 repository for fetching anime content from Rule34 API
    getIt.registerLazySingleton<IAnimeRepository>(
      () => Rule34AnimeRepository(
        baseUrl: getIt<Constants>().rule34Api,
        networkClient: GetIt.I<INetworkClient>(),
      ),
      // Named instance for Rule34 specific implementation
      instanceName: 'rule34Repository',
    );

    // Waifu repository for fetching anime content from Waifu API
    getIt.registerLazySingleton<IAnimeRepository>(
      () => BaseAnimeRepository(
        baseUrl: getIt<Constants>().animeFetchUrl,
        networkClient: GetIt.I<INetworkClient>(),
      ),
      // Named instance for Waifu specific implementation
      instanceName: 'waifuRepository',
    );
  }
}
