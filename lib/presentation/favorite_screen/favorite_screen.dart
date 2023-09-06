import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_test_app/common/custom_theme.dart';
import 'package:github_test_app/presentation/favorite_screen/favorite_screen_appbar.dart';
import 'package:github_test_app/presentation/favorite_screen/favorite_screen_cubit/favorite_screen_cubit.dart';
import 'package:github_test_app/presentation/favorite_screen/favorite_screen_cubit/favorite_screen_state.dart';

import '../../common/string_resources.dart';
import '../standalone_widgets/card_item_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late final FavoriteScreenCubit favoriteScreenCubit;

  @override
  void initState() {
    super.initState();
    favoriteScreenCubit = FavoriteScreenCubit();
    favoriteScreenCubit.getFavoriteRepositories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FavoriteScreenAppBar(
            onBackPressed: () => {Navigator.of(context).pop()},
            title: StringResources.favoritePageTitle),
        body: FavoritesWidget(favoriteScreenCubit: favoriteScreenCubit));
  }
}

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({
    required this.favoriteScreenCubit,
    super.key,
  });

  final FavoriteScreenCubit favoriteScreenCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => favoriteScreenCubit,
      child: BlocBuilder<FavoriteScreenCubit, FavoriteScreenState>(
        builder: (context, state) {
          if (state is FavoriteScreenLoadedState) {
            if (state.repositories.repositories.isNotEmpty) {
              return buildFullFavoriteScreen(state);
            } else {
              return buildEmptyFavoritesWidget();
            }
          } else {
            return buildUnknownStateWidget();
          }
        },
      ),
    );
  }

  Widget buildUnknownStateWidget() {
    return const Center(
      child: Text(
        textAlign: TextAlign.center,
        StringResources.unknownErrorMessage,
        style: CustomTextStyles.infoMessageStyle,
      ),
    );
  }

  Widget buildEmptyFavoritesWidget() {
    return const Center(
      child: Text(
        textAlign: TextAlign.center,
        StringResources.noFavoritesMessage,
        style: CustomTextStyles.infoMessageStyle,
      ),
    );
  }

  Widget buildFullFavoriteScreen(FavoriteScreenLoadedState state) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: state.repositories.repositories.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return CardItemWidget(
                  isFavorite: state.repositories.repositories[index].isFavorite,
                  repository: state.repositories.repositories[index],
                  index: index,
                  onFavoritePressed: () => {
                        favoriteScreenCubit.removeRepositoryFromFavorite(
                            state.repositories.repositories[index])
                      });
            },
          ),
        )
      ],
    );
  }
}
