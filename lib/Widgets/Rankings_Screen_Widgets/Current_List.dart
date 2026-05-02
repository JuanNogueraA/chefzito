import 'package:flutter/material.dart';
import 'Recipe_Card.dart';
import 'Chef_Card.dart';
import 'Ingredient_Item.dart';

class CurrentList extends StatelessWidget {
  final int selectedTab;

  const CurrentList({Key? key, required this.selectedTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedTab == 0) {
      return Column(
        children: const [
          RecipeCard(rank: 1, title: "Tarta de Chocolate", views: "1245", likes: "3421", trend: "+23%", imgUrl: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=200&auto=format&fit=crop'),
          RecipeCard(rank: 2, title: "Pasta Carbonara Clásica", views: "987", likes: "2876", trend: "+18%", imgUrl: 'https://images.unsplash.com/photo-1612874742237-6526221588e3?q=80&w=200&auto=format&fit=crop'),
          RecipeCard(rank: 3, title: "Tacos al Pastor", views: "876", likes: "2543", trend: "+15%", imgUrl: 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?q=80&w=200&auto=format&fit=crop'),
          RecipeCard(rank: 4, title: "Salmón Glaseado", views: "734", likes: "2198", trend: "+12%", imgUrl: 'https://images.unsplash.com/photo-1485921325833-c519f76c4927?q=80&w=200&auto=format&fit=crop'),
        ],
      );
    } else if (selectedTab == 1) {
      return Column(
        children: const [
          ChefCard(rank: 1, name: "María García", handle: "@mariachef", subtitle: "45 recetas • 12.400", score: "23.450", imgUrl: 'https://randomuser.me/api/portraits/women/44.jpg'),
          ChefCard(rank: 2, name: "Carlos Ruiz", handle: "@carloscocina", subtitle: "38 recetas • 10.200", score: "19.876", imgUrl: 'https://randomuser.me/api/portraits/men/32.jpg'),
          ChefCard(rank: 3, name: "Ana López", handle: "@analove", subtitle: "52 recetas • 9.800", score: "18.234", imgUrl: 'https://randomuser.me/api/portraits/women/68.jpg'),
          ChefCard(rank: 4, name: "Pedro Sánchez", handle: "@pedrocooks", subtitle: "29 recetas • 8.500", score: "15.670", imgUrl: 'https://randomuser.me/api/portraits/men/45.jpg'),
        ],
      );
    } else {
      return Column(
        children: const [
          IngredientItem(rank: 1, name: "Aguacate", subtitle: "1234 usos esta semana", trend: "+45%"),
          IngredientItem(rank: 2, name: "Quinoa", subtitle: "987 usos esta semana", trend: "+38%"),
          IngredientItem(rank: 3, name: "Tofu", subtitle: "876 usos esta semana", trend: "+32%"),
          IngredientItem(rank: 4, name: "Jengibre", subtitle: "745 usos esta semana", trend: "+28%"),
          IngredientItem(rank: 5, name: "Cúrcuma", subtitle: "698 usos esta semana", trend: "+25%"),
        ],
      );
    }
  }
}