import 'package:daily_recipe/models/recipe.model.dart';

class Favorites{
  List<FavoriteRecipe>? favoriteRecipes;



  Favorites();

  Favorites.fromJson(Map<String, dynamic> data) {
    favoriteRecipes = data['favoriteRecipes'] != null
        ? List.from(data['favoriteRecipes'].map((e) => FavoriteRecipe.fromJson(e)))
        : null;


  }

  Map<String, dynamic> toJson() => {
    "favoriteRecipes": favoriteRecipes?.map((e) => e.toJson()),

  };}
  class FavoriteRecipe {

  String? recipeId;
 List<Recipe> ? recipe;


  FavoriteRecipe();

  FavoriteRecipe.fromJson(Map<String, dynamic> data,[String? id]) {
    recipeId=id;
    recipe=(data['recipe'] != null
        ? List.from(data['recipes'].map((e) =>Recipe.fromJson(e)))
        : null) ;


  }

  Map<String, dynamic> toJson() => {
    "recipe":recipe,
       "recipeId":recipeId,
  };



}