import '../model/repository_model.dart';
import '../model/search_history_model.dart';

abstract class StorageDataSource {
  Future<RepositoryModel> getFavoriteRepositories();
  Future<void> addRepositoryToFavorite(
      Repository repository, RepositoryModel oldRepositoryModel);
  Future<void> removeRepositoryFromFavorite(
      Repository repository, RepositoryModel oldRepositoryModel);

  Future<SearchHistoryModel> getSearchHistory();

  Future<void> addItemToSearchHistory(
      String item, SearchHistoryModel oldSearchHistoryModel);
}
