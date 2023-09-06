import '../model/repository_model.dart';
import '../model/search_history_model.dart';

abstract class StorageRepo {
  Future<RepositoryModel> getFavoriteRepositories();

  Future<void> addRepositoryToFavorite(
      {required Repository repository,
      required RepositoryModel oldRepositoryModel});

  Future<void> removeRepositoryFromFavorite(
      {required Repository repository,
      required RepositoryModel oldRepositoryModel});

  Future<SearchHistoryModel> getSearchHistory();

  Future<void> addItemToSearchHistory(
      {required String item,
      required SearchHistoryModel oldSearchHistoryModel});
}
