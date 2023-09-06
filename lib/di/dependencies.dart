import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_test_app/data/data_source/remote_data_source_impl.dart';
import 'package:github_test_app/data/data_source/storage_data_source_impl.dart';
import 'package:github_test_app/data/repository/remote_repo_impl.dart';
import 'package:github_test_app/data/repository/storage_repo_impl.dart';
import 'package:github_test_app/domain/repository/remote_repo.dart';
import 'package:github_test_app/domain/repository/storage_repo.dart';

final dependencies = GetIt.instance;

Future<void> initDependencies() async {
  final dio = Dio();

  dependencies.registerLazySingleton<RemoteRepo>(
      () => RemoteRepoImpl(RemoteDataSourceImpl(dio)));

  dependencies.registerLazySingleton<StorageRepo>(
      () => StorageRepoImpl(StorageDataSourceImpl()));
}
