import '../model/repository_model.dart';

abstract class RemoteDataSource {
  Future<RepositoryModel> getRepositories(
      {required String keyword, int perPage = 15});
}
