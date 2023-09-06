import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_test_app/common/custom_colors.dart';
import 'package:github_test_app/presentation/search_screen/search_screen_appbar.dart';
import 'package:github_test_app/common/string_resources.dart';
import 'package:github_test_app/presentation/search_screen/search_screen_cubit/search_screen_cubit.dart';
import 'package:github_test_app/presentation/search_screen/search_screen_cubit/search_screen_state.dart';
import 'package:github_test_app/presentation/search_screen/search_screen_history_cubit/search_screen_history_cubit.dart';
import 'package:github_test_app/presentation/search_screen/search_screen_history_cubit/search_screen_history_state.dart';
import '../../common/custom_theme.dart';
import '../standalone_widgets/card_item_widget.dart';
import '../standalone_widgets/search_card_item_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchScreenCubit searchScreenCubit;
  late final SearchScreenHistoryCubit searchScreenHistoryCubit;

  final FocusNode focusNode = FocusNode();

  TextEditingController textEditingController = TextEditingController();
  Color fillColor = CustomColors.textFieldFillDisabledColor;

  @override
  void initState() {
    super.initState();

    searchScreenCubit = context.read<SearchScreenCubit>();
    searchScreenHistoryCubit = context.read<SearchScreenHistoryCubit>();

    focusNode.addListener(onFocusChange);

    textEditingController = TextEditingController();
    searchScreenHistoryCubit.getSearchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchScreenAppBar(
          onFavoritePressed: () => onFavoritePressed(),
          title: StringResources.searchPageTitle),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSearchBar(),
              BlocConsumer<SearchScreenCubit, SearchScreenState>(
                builder: (context, state) {
                  if (state is SearchScreenLoadedState) {
                    if (state.repositories.repositories.isNotEmpty) {
                      return buildFullRepositoryState(state);
                    } else {
                      return buildEmptyRepositoryState(context);
                    }
                  }
                  if (state is SearchScreenLoadingState) {
                    return buildLoadingState();
                  }
                  if (state is SearchScreenErrorState) {
                    return buildLoadingErrorState(context);
                  } else {
                    return BlocBuilder<SearchScreenHistoryCubit,
                        SearchScreenHistoryState>(
                      builder: (context, state) {
                        if (state is SearchScreenHistoryLoadedState) {
                          if (state.searchHistoryModel.history.isNotEmpty) {
                            return buildFullSearchHistoryState(state);
                          } else {
                            return buildEmptySearchHistoryState();
                          }
                        } else {
                          return buildSearchHistoryLoadingState();
                        }
                      },
                    );
                  }
                },
                listener: (context, state) {
                  if (state is SearchScreenInitialState) {
                    searchScreenHistoryCubit.getSearchHistory();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchHistoryLoadingState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Text(StringResources.searchHistory,
              style: CustomTextStyles.searchSubtitleStyle),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
        )
      ],
    );
  }

  Widget buildEmptySearchHistoryState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Text(StringResources.searchHistory,
              style: CustomTextStyles.searchSubtitleStyle),
        ),
        SizedBox(
            height: 400,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Text(
                  StringResources.emptySearchHistory,
                  style: CustomTextStyles.infoMessageStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            )),
      ],
    );
  }

  Widget buildFullSearchHistoryState(SearchScreenHistoryLoadedState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Text(StringResources.searchHistory,
              style: CustomTextStyles.searchSubtitleStyle),
        ),
        SizedBox(
          width: double.infinity,
          height: 400,
          child: ListView.builder(
            itemCount: state.searchHistoryModel.history.length,
            itemBuilder: (context, index) {
              return SearchCardItemWidget(
                  title: state.searchHistoryModel.history[index].name);
            },
          ),
        ),
      ],
    );
  }

  Widget buildLoadingErrorState(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: const Center(
        child: Text(
            textAlign: TextAlign.center,
            StringResources.errorSearchMessage,
            style: CustomTextStyles.infoMessageStyle),
      ),
    );
  }

  Widget buildLoadingState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget buildEmptyRepositoryState(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Text(StringResources.whatWeHaveFound,
              style: CustomTextStyles.searchSubtitleStyle),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: const Center(
            child: Text(
                textAlign: TextAlign.center,
                StringResources.emptySearchMessage,
                style: CustomTextStyles.infoMessageStyle),
          ),
        ),
      ],
    );
  }

  Widget buildFullRepositoryState(SearchScreenLoadedState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Text(StringResources.whatWeHaveFound,
              style: CustomTextStyles.searchSubtitleStyle),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: state.repositories.repositories.length,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return FutureBuilder(
                future: searchScreenCubit.isRepositoryStoresAsFavorite(
                    state.repositories.repositories[index], index),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CardItemWidget(
                      isFavorite: snapshot.data!,
                      index: index,
                      onFavoritePressed: () =>
                          searchScreenCubit.changeRepositoryFavoriteStatus(
                        state.repositories.repositories[index],
                      ),
                      repository: state.repositories.repositories[index],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                });
          },
        )
      ],
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: TextField(
        focusNode: focusNode,
        style: CustomTextStyles.searchTextInputStyle,
        controller: textEditingController,
        keyboardType: TextInputType.text,
        onSubmitted: (value) => onSearchPressed(),
        decoration: InputDecoration(
          hintStyle: CustomTextStyles.searchHintInputStyle,
          hintText: StringResources.searchTextInputHint,
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: CustomColors.primaryAppColor,
          ),
          suffixIcon: IconButton(
              onPressed: () => onSearchDismissPressed(),
              icon: const Icon(Icons.cancel_outlined)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          filled: true,
          fillColor: fillColor,
        ),
      ),
    );
  }

  void onSearchDismissPressed() {
    if (textEditingController.text.isNotEmpty) {
      textEditingController.clear();
    }
    searchScreenCubit.resetState();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onSearchPressed() {
    searchScreenHistoryCubit.addItemToSearchHistory(textEditingController.text);
    searchScreenCubit.getRepositories(keyword: textEditingController.text);
    debugPrint(textEditingController.text);
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      setState(() {
        fillColor = CustomColors.textFieldFillEnabledColor;
      });
    } else {
      setState(() {
        fillColor = CustomColors.textFieldFillDisabledColor;
      });
    }
  }

  void onFavoritePressed() {
    Navigator.pushNamed(context, '/favorite').then((value) {
      if (textEditingController.text.isNotEmpty) {
        searchScreenCubit.getRepositories(keyword: textEditingController.text);
      }
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.removeListener(onFocusChange);
    super.dispose();
  }
}
