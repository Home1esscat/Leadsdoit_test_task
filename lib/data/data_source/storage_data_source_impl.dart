import 'dart:async';
import 'dart:convert';

import 'package:github_test_app/domain/data_source/storage_data_source.dart';
import 'package:github_test_app/domain/model/repository_model.dart';
import 'package:github_test_app/domain/model/search_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageDataSourceImpl implements StorageDataSource {
  StorageDataSourceImpl();

  static const String favoriteKey = 'FAVORITE';
  static const String historyKey = 'HISTORY';

  @override
  Future<RepositoryModel> getFavoriteRepositories() async {
    final prefs = await SharedPreferences.getInstance();

    String? storedValue = prefs.getString(favoriteKey);

    if (storedValue == null) {
      return RepositoryModel(repositories: []);
    } else {
      Map<String, dynamic> data = json.decode(storedValue);
      return RepositoryModel.fromJson(data);
    }
  }

  @override
  Future<void> addRepositoryToFavorite(
      Repository repository, RepositoryModel oldRepositoryModel) async {
    final prefs = await SharedPreferences.getInstance();
    oldRepositoryModel.repositories.insert(0,
        Repository(id: repository.id, name: repository.name, isFavorite: true));
    prefs.setString(favoriteKey, json.encode(oldRepositoryModel));
  }

  @override
  Future<void> removeRepositoryFromFavorite(
      Repository repository, RepositoryModel oldRepositoryModel) async {
    final prefs = await SharedPreferences.getInstance();
    repository.isFavorite = false;
    oldRepositoryModel.repositories
        .removeWhere((element) => element.id == repository.id);
    prefs.setString(favoriteKey, json.encode(oldRepositoryModel));
  }

  @override
  Future<void> addItemToSearchHistory(
      String item, SearchHistoryModel oldSearchHistoryModel) async {
    final prefs = await SharedPreferences.getInstance();
    oldSearchHistoryModel.history.insert(0, SearchHistoryItem(name: item));
    prefs.setString(historyKey, json.encode(oldSearchHistoryModel));
  }

  @override
  Future<SearchHistoryModel> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();

    String? storedValue = prefs.getString(historyKey);

    if (storedValue == null) {
      return SearchHistoryModel(history: []);
    } else {
      Map<String, dynamic> data = json.decode(storedValue);
      return SearchHistoryModel.fromJson(data);
    }
  }
}
