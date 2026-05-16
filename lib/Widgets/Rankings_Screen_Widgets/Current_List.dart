import 'package:flutter/material.dart';

import 'package:chefzito/models/recipe_model.dart';
import 'package:chefzito/models/user_model.dart';

import 'Recipe_Card.dart';
import 'Chef_Card.dart';
import 'Ingredient_Item.dart';

class RecipeRankingItem {
  final RecipeModel recipe;
  final int postsCount;
  final int likes;

  const RecipeRankingItem({
    required this.recipe,
    required this.postsCount,
    required this.likes,
  });
}

class ChefRankingItem {
  final UserModel user;
  final int recipeCount;
  final int likes;

  const ChefRankingItem({
    required this.user,
    required this.recipeCount,
    required this.likes,
  });
}

class CurrentList extends StatelessWidget {
  final int selectedTab;
  final List<RecipeRankingItem> recipeRankings;
  final List<ChefRankingItem> chefRankings;
  final List<MapEntry<String, int>> ingredientRankings;

  const CurrentList({
    Key? key,
    required this.selectedTab,
    required this.recipeRankings,
    required this.chefRankings,
    required this.ingredientRankings,
  }) : super(key: key);

  String _displayName(UserModel user) {
    if (user.username.trim().isNotEmpty) {
      return user.username;
    }
    final email = user.email.trim();
    if (email.isNotEmpty) {
      return email.split('@').first;
    }
    return 'Chef';
  }

  @override
  Widget build(BuildContext context) {
    if (selectedTab == 0) {
      if (recipeRankings.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(child: Text('No hay recetas disponibles.')),
        );
      }
      return Column(
        children: recipeRankings.asMap().entries.map((entry) {
          final index = entry.key;
          final data = entry.value;
          return RecipeCard(
            rank: index + 1,
            title: data.recipe.title,
            postsCount: data.postsCount,
            likes: data.likes,
            trend: '+${data.postsCount}',
            imgUrl: data.recipe.coverImageUrl,
          );
        }).toList(),
      );
    } else if (selectedTab == 1) {
      if (chefRankings.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(child: Text('No hay chefs disponibles.')),
        );
      }
      return Column(
        children: chefRankings.asMap().entries.map((entry) {
          final index = entry.key;
          final data = entry.value;
          final name = _displayName(data.user);
          return ChefCard(
            rank: index + 1,
            name: name,
            handle: '@${data.user.username.isEmpty ? name : data.user.username}',
            subtitle: '${data.recipeCount} recetas',
            score: '${data.likes}',
            imgUrl: data.user.avatarUrl,
          );
        }).toList(),
      );
    } else {
      if (ingredientRankings.isEmpty) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(child: Text('No hay ingredientes destacados.')),
        );
      }
      return Column(
        children: ingredientRankings.asMap().entries.map((entry) {
          final index = entry.key;
          final data = entry.value;
          return IngredientItem(
            rank: index + 1,
            name: data.key,
            subtitle: '${data.value} recetas',
            trend: '+${data.value}',
          );
        }).toList(),
      );
    }
  }
}
