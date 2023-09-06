import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_test_app/di/dependencies.dart';
import 'package:github_test_app/domain/repository/remote_repo.dart';
import 'package:github_test_app/presentation/search_screen/search_screen_cubit/search_screen_state.dart';

import '../../../domain/model/repository_model.dart';
import '../../../domain/repository/storage_repo.dart';

class SearchScreenCubit extends Cubit<SearchScreenState> {
  SearchScreenCubit() : super(SearchScreenInitialState());

  final RemoteRepo remoteRepo = dependencies.get<RemoteRepo>();
  final StorageRepo storageRepo = dependencies.get<StorageRepo>();

  late RepositoryModel internalRepositories;

  Future<void> getRepositories(
      {required String keyword, int perPage = 15}) async {
    emit(SearchScreenLoadingState());
    try {
      var repositories =
          await remoteRepo.getRepositories(keyword: keyword, perPage: perPage);
      internalRepositories = repositories;
      emit(SearchScreenLoadedState(repositories: internalRepositories));
    } catch (e) {
      emit(SearchScreenErrorState());
    }
  }

  Future<void> changeRepositoryFavoriteStatus(Repository repository) async {
    var oldRepository = await storageRepo.getFavoriteRepositories();

    if (repository.isFavorite == true) {
      repository.isFavorite = false;

      await storageRepo.removeRepositoryFromFavorite(
          repository: repository, oldRepositoryModel: oldRepository);

      for (var element in internalRepositories.repositories) {
        if (element.id == repository.id) {
          element.isFavorite = false;
        }
      }
    } else if (repository.isFavorite == false) {
      repository.isFavorite = true;

      await storageRepo.addRepositoryToFavorite(
          repository: repository, oldRepositoryModel: oldRepository);

      for (var element in internalRepositories.repositories) {
        if (element.id == repository.id) {
          element.isFavorite = true;
        }
      }
    }

    emit(SearchScreenLoadedState(repositories: internalRepositories));
  }

  Future<bool> isRepositoryStoresAsFavorite(
      Repository repository, int index) async {
    int exist = 0;
    var favoriteRepositories = await storageRepo.getFavoriteRepositories();

    for (var element in favoriteRepositories.repositories) {
      if (element.id == repository.id) {
        exist = 1;
        repository.isFavorite = true;
      }
    }

    return exist == 1;
  }

  Future<void> resetState() async {
    emit(SearchScreenInitialState());
  }
}
