import 'package:github_test_app/domain/data_source/storage_data_source.dart';
import 'package:github_test_app/domain/model/repository_model.dart';
import 'package:github_test_app/domain/model/search_history_model.dart';
import 'package:github_test_app/domain/repository/storage_repo.dart';

class StorageRepoImpl implements StorageRepo {
  final StorageDataSource _storageDataSource;

  StorageRepoImpl(this._storageDataSource);

  @override
  Future<RepositoryModel> getFavoriteRepositories() {
    return _storageDataSource.getFavoriteRepositories();
  }

  @override
  Future<void> addRepositoryToFavorite(
      {required Repository repository,
      required RepositoryModel oldRepositoryModel}) {
    return _storageDataSource.addRepositoryToFavorite(
        repository, oldRepositoryModel);
  }

  @override
  Future<void> removeRepositoryFromFavorite(
      {required Repository repository,
      required RepositoryModel oldRepositoryModel}) {
    return _storageDataSource.removeRepositoryFromFavorite(
        repository, oldRepositoryModel);
  }

  @override
  Future<void> addItemToSearchHistory(
      {required String item,
      required SearchHistoryModel oldSearchHistoryModel}) {
    return _storageDataSource.addItemToSearchHistory(
        item, oldSearchHistoryModel);
  }

  @override
  Future<SearchHistoryModel> getSearchHistory() {
    return _storageDataSource.getSearchHistory();
  }
}
