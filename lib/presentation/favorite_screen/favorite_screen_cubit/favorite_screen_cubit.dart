import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_test_app/domain/model/repository_model.dart';
import 'package:github_test_app/domain/repository/storage_repo.dart';
import 'package:github_test_app/presentation/favorite_screen/favorite_screen_cubit/favorite_screen_state.dart';

import '../../../di/dependencies.dart';

class FavoriteScreenCubit extends Cubit<FavoriteScreenState> {
  FavoriteScreenCubit() : super(FavoriteScreenInitialState());

  final StorageRepo storageRepo = dependencies.get<StorageRepo>();

  Future<void> getFavoriteRepositories() async {
    emit(FavoriteScreenLoadingState());
    var recentRepositories = await storageRepo.getFavoriteRepositories();
    emit(FavoriteScreenLoadedState(repositories: recentRepositories));
  }

  Future<void> removeRepositoryFromFavorite(Repository repository) async {
    var oldRepository = await storageRepo.getFavoriteRepositories();
    await storageRepo.removeRepositoryFromFavorite(
        repository: repository, oldRepositoryModel: oldRepository);
    var updatedRecentRepositories = await storageRepo.getFavoriteRepositories();
    emit(FavoriteScreenLoadedState(repositories: updatedRecentRepositories));
  }

//  @override
//   Future<RepositoryModel> getRecentRepositories() {
//     return _storageDataSource.getRecentRepositories();
//   }

//   @override
//   Future<void> addRecentRepository(
//       Repository repository, RepositoryModel oldRepositoryModel) {
//     return _storageDataSource.addRecentRepository(repository, oldRepositoryModel);
//   }
}
