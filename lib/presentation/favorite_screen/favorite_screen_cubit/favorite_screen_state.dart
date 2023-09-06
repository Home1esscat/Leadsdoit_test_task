import '../../../domain/model/repository_model.dart';

class FavoriteScreenState {}

class FavoriteScreenInitialState extends FavoriteScreenState {}

class FavoriteScreenLoadingState extends FavoriteScreenState {}

class FavoriteScreenLoadedState extends FavoriteScreenState {
  RepositoryModel repositories;
  FavoriteScreenLoadedState({required this.repositories});
}

class FavoriteScreenErrorState extends FavoriteScreenState {}
