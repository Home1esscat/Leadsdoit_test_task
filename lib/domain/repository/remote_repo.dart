import 'package:github_test_app/domain/model/repository_model.dart';

abstract class RemoteRepo {
  Future<RepositoryModel> getRepositories(
      {required String keyword, int perPage = 15});
}
