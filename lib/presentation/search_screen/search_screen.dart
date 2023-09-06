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
import '../../domain/model/repository_model.dart';
import '../standalone_widgets/card_item_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchScreenCubit searchScreenCubit;
  //late final SearchScreenHistoryCubit searchScreenHistoryCubit;
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late Color fillColor;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(onFocusChange);
    fillColor = CustomColors.textFieldFillDisabledColor;
    searchScreenCubit = context.read<SearchScreenCubit>();
    //searchScreenHistoryCubit = context.read<SearchScreenHistoryCubit>();
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
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  focusNode: _focusNode,
                  style: CustomTextStyles.searchTextInputStyle,
                  controller: _textEditingController,
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    filled: true,
                    fillColor: fillColor,
                  ),
                ),
              ),
              BlocConsumer<SearchScreenCubit, SearchScreenState>(
                builder: (context, state) {
                  if (state is SearchScreenLoadedState) {
                    if (state.repositories.repositories.isNotEmpty) {
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
                                  future: searchScreenCubit
                                      .isRepositoryStoresAsFavorite(
                                          state
                                              .repositories.repositories[index],
                                          index),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return CardItemWidget(
                                        isFavorite: snapshot.data!,
                                        index: index,
                                        onFavoritePressed: () =>
                                            searchScreenCubit
                                                .changeRepositoryFavoriteStatus(
                                          state
                                              .repositories.repositories[index],
                                        ),
                                        repository: state
                                            .repositories.repositories[index],
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  });
                            },
                          )
                        ],
                      );
                    } else {
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
                  }
                  if (state is SearchScreenLoadingState) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is SearchScreenErrorState) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: const Center(
                        child: Text(
                            textAlign: TextAlign.center,
                            StringResources.errorSearchMessage,
                            style: CustomTextStyles.infoMessageStyle),
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                          child: Text(StringResources.searchHistory,
                              style: CustomTextStyles.searchSubtitleStyle),
                        ),
                        SizedBox(
                          height: 400,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.red,
                          ),
                        )
                      ],
                    );
                  }
                },
                listener: (context, state) {
                  if (state is SearchScreenInitialState) {}
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSearchDismissPressed() {
    if (_textEditingController.text.isNotEmpty) {
      _textEditingController.clear();
    }
    searchScreenCubit.resetState();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onSearchPressed() {
    // searchScreenHistoryCubit
    //     .addItemToSearchHistory(_textEditingController.text);
    searchScreenCubit.getRepositories(keyword: _textEditingController.text);
    debugPrint(_textEditingController.text);
  }

  void onFocusChange() {
    if (_focusNode.hasFocus) {
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
    Navigator.pushNamed(context, '/favorite').then((value) => searchScreenCubit
        .getRepositories(keyword: _textEditingController.text));
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.removeListener(onFocusChange);
    super.dispose();
  }
}
