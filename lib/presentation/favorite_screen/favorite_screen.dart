import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_test_app/common/custom_theme.dart';
import 'package:github_test_app/domain/model/repository_model.dart';
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
    favoriteScreenCubit = context.read<FavoriteScreenCubit>();
    favoriteScreenCubit.getFavoriteRepositories();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;

    return Scaffold(
      appBar: FavoriteScreenAppBar(
          onBackPressed: () => {Navigator.of(context).pop()},
          title: StringResources.favoritePageTitle),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: isEmpty
            // ignore: dead_code
            ? const EmptyFavoritesWidget()
            : FullFavoritesWidget(favoriteScreenCubit: favoriteScreenCubit),
      ),
    );
  }
}

class FullFavoritesWidget extends StatelessWidget {
  const FullFavoritesWidget({
    required this.favoriteScreenCubit,
    super.key,
  });

  final FavoriteScreenCubit favoriteScreenCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteScreenCubit, FavoriteScreenState>(
      builder: (context, state) {
        if (state is FavoriteScreenLoadedState) {
          if (state.repositories.repositories.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.repositories.repositories.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return CardItemWidget(
                          isFavorite:
                              state.repositories.repositories[index].isFavorite,
                          repository: state.repositories.repositories[index],
                          index: index,
                          onFavoritePressed: () => {
                                favoriteScreenCubit
                                    .removeRepositoryFromFavorite(
                                        state.repositories.repositories[index])
                              });
                    },
                  ),
                )
              ],
            );
          } else {
            return const SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  StringResources.noFavoritesMessage,
                  style: CustomTextStyles.infoMessageStyle,
                ),
              ),
            );
          }
        } else {
          return Container(
            color: Colors.green,
            width: double.infinity,
            height: double.infinity,
          );
        }
      },
    );
  }
}

class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
            textAlign: TextAlign.center,
            StringResources.noFavoritesMessage,
            style: CustomTextStyles.infoMessageStyle));
  }
}
