class Ingredient {
  String? docId;
  String? name;
  //String? imageUrl;
  List<String>? usersIng_ids;

  Ingredient();

  Ingredient.fromJson(Map<String, dynamic> data, [String? id]) {
    docId = id;
    name = data['name'];
    //imageUrl = data['imageUrl'];
    usersIng_ids = data['usersIng_ids'] != null
        ? List<String>.from(data['usersIng_ids'].map((e) => e.toString()))
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
     // "imageUrl": imageUrl,
      "usersIng_ids": usersIng_ids,
    };
  }
}