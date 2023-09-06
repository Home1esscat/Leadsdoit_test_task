import '../../../domain/model/search_history_model.dart';

class SearchScreenHistoryState {}

class SearchScreenHistoryInitialState extends SearchScreenHistoryState {}

class SearchScreenHistoryLoadingState extends SearchScreenHistoryState {}

class SearchScreenHistoryLoadedState extends SearchScreenHistoryState {
  SearchHistoryModel searchHistoryModel;
  SearchScreenHistoryLoadedState({required this.searchHistoryModel});
}

class SearchScreenHistoryErrorState extends SearchScreenHistoryState {}
