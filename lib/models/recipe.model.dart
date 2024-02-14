

class Recipe {
  String? docId;
  String? mealType;
  String? title;
  String? description;
  String? image;
  int? rating;
  int? prepTime;
  int? serving;
  int? calories;
  List<dynamic>?ingredients;
  Map<String,dynamic>? directions;
  List<dynamic>?user_ids;
  List<dynamic>?viewed_ids;
  bool? favorite;
  bool? isRead;

  Recipe();

  Recipe.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
    mealType = data['meal_type'];
    description = data['description'];
    title = data['title'];
    image = data['image'];
    serving = data['serving'];
    prepTime = data['prep_time'];
    calories = data['calories'];
    rating = data['rating'];
    ingredients = data['ingredients'];
    directions= data['directions'];
    favorite=data['favorite'];
    isRead=data['isRead'];
    user_ids = data['user_ids'] != null

        ? List<String>.from(data['user_ids'].map((e) => e.toString()))
        : null;
    viewed_ids = data['viewed_ids'] != null

        ? List<String>.from(data['viewed_ids'].map((e) => e.toString()))
        : null;
  }

  Map<String, dynamic> toJson() {
    return {

      'meal_type': mealType,
      "title": title,
      'description': description,
      "image": image,
      'rating': rating,
      "calories": calories,
      "prep_time": prepTime,
      "serving": serving,
      "ingredients":ingredients,
      'directions':directions,
      'user_ids':user_ids,
      'favorite':favorite,
      'isRead':isRead,
      'viewed_ids':viewed_ids,
    };
  }



}
