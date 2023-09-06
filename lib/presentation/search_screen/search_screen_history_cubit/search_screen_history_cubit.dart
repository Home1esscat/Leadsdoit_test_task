import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_test_app/presentation/search_screen/search_screen_history_cubit/search_screen_history_state.dart';

import '../../../di/dependencies.dart';
import '../../../domain/repository/storage_repo.dart';

class SearchScreenHistoryCubit extends Cubit<SearchScreenHistoryState> {
  SearchScreenHistoryCubit() : super(SearchScreenHistoryInitialState());

  final StorageRepo storageRepo = dependencies.get<StorageRepo>();

  Future<void> getSearchHistory() async {
    emit(SearchScreenHistoryLoadingState());
    var searchHistory = await storageRepo.getSearchHistory();
    emit(SearchScreenHistoryLoadedState(searchHistoryModel: searchHistory));
  }

  Future<void> addItemToSearchHistory(String item) async {
    var oldSearchHistory = await storageRepo.getSearchHistory();
    storageRepo.addItemToSearchHistory(
        item: item, oldSearchHistoryModel: oldSearchHistory);
  }
}
