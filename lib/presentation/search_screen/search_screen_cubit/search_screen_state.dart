import '../../../domain/model/repository_model.dart';

class SearchScreenState {}

class SearchScreenInitialState extends SearchScreenState {}

class SearchScreenLoadingState extends SearchScreenState {}

class SearchScreenLoadedState extends SearchScreenState {
  RepositoryModel repositories;
  SearchScreenLoadedState({required this.repositories});
}

class SearchScreenErrorState extends SearchScreenState {}
