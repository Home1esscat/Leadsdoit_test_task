import 'package:github_test_app/domain/data_source/remote_data_source.dart';
import 'package:github_test_app/domain/model/repository_model.dart';
import 'package:github_test_app/domain/repository/remote_repo.dart';

class RemoteRepoImpl implements RemoteRepo {
  final RemoteDataSource _dataSource;

  RemoteRepoImpl(this._dataSource);
  @override
  Future<RepositoryModel> getRepositories(
      {required String keyword, int perPage = 15}) {
    return _dataSource.getRepositories(keyword: keyword, perPage: perPage);
  }
}
