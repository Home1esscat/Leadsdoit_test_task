import 'package:dio/dio.dart';
import 'package:github_test_app/common/api_constants.dart';
import 'package:github_test_app/domain/data_source/remote_data_source.dart';
import 'package:github_test_app/domain/model/repository_model.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl(this.dio);
  final Dio dio;

  @override
  Future<RepositoryModel> getRepositories(
      {required String keyword, perPage = 15}) async {
    Uri uri = Uri.https(ApiConstants.baseURL, ApiConstants.search);
    Map<String, dynamic> queryParameters = {'per_page': perPage, 'q': keyword};
    var result =
        await dio.get(uri.toString(), queryParameters: queryParameters);
    var models = RepositoryModel.fromJson(result.data);
    return models;
  }
}
