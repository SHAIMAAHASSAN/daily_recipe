import 'package:daily_recipe/widgets/card.recipe.dart';

class Recipe {
  int? id;
  String? mealType;
  String? title;
  String? description;
  String? image;
  int? rating;
  int? prepTime;
  int? serving;
  double? calories;

  Recipe();
  //Recipe({required this.mealType,required this.title,required this.image
   // ,required this.calories,required this.prepTime,required this.serving});
  Recipe.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    mealType = data['meal_type'];
    description = data['description'];
    title = data['title'];
    image = data['image'];
    serving = data['serving'];
    prepTime = data['prep_time'];
    calories = data['calories'];
    rating = data['rating'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meal_type': mealType,
      "title": title,
      'description': description,
      "image": image,
      'rating': rating,
      "calories": calories,
      "prep_time": prepTime,
      "serving": serving,
    };
  }



}
