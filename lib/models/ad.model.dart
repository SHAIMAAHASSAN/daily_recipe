class Ad {
  String? title;
  String? image;
  String? docId;

  Ad();

  Ad.fromJson(Map<String, dynamic> data,[String? id]) {
    docId=id;
    title = data['title'];
    image = data['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "image": image,
    };
  }
}