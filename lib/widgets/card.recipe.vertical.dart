import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:daily_recipe/widgets/favorite.icon.dart';
import 'package:flutter/material.dart';

class CardRecipeVertical extends StatefulWidget {
  CardRecipeVertical(
      {super.key,
        required this.recipe
      /*required this.mealType,
      required this.title,
      required this.image,
      required this.calories,
      required this.prepTime,
      required this.serving,required this.currentIndex*/});

  Recipe recipe;
 /* String? mealType;
  String? title;
  //String? description;
  String? image;
  // int? rating;
  int? prepTime;
  int? serving;
  int? calories;
  int currentIndex;*/

  @override
  State<CardRecipeVertical> createState() => _CardRecipeVerticalState();
}

class _CardRecipeVerticalState extends State<CardRecipeVertical> {
  Color _color = Colors.grey;
  bool isfavorite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20), // Adjust radius as needed
          // border: Border.all(color: Colors.black, width: 2), // Optional border
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(right: 4.0, left: 4, top: 8, bottom: 8),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
             // mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  //color: Colors.cyan,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Image(
                      image: NetworkImage(widget.recipe.image!),
                      alignment: Alignment.center,
                      width: 90,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipe.mealType!,
                      style: TextStyle(color: Colors.cyan[600], fontSize: 16),
                    ),
                    SizedBox(width: 170,
                      child: Text(
                        widget.recipe.title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
//const Text("description"),
                    Row(
                      children: [
                        AnimatedRatingBar(
                          width: 80,
                          initialRating: 0,
                          animationColor: Colors.yellow,
                          strokeColor: Colors.grey,
                          activeFillColor: Colors.deepOrange,
                          onRatingUpdate: (double value) {
                            setState(() {});
                          },
                        ),
                        SizedBox(width: 10,),
                        Text(" ${widget.recipe.calories} Calories",
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 14)),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.access_time_outlined),
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(" ${widget.recipe.prepTime!} mins",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                            ),
                          ],
                        ),
                        SizedBox(
                          width:10,
                        ),
                        Row(
                          children: [
                            Icon(Icons.dinner_dining),
                            Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(" ${widget.recipe.serving} serving",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(width: 8,),
                Align(
                  alignment: Alignment.topRight,
                  child:FavoriteIcon(recipe: widget.recipe),

                  /*GestureDetector(
                    onTap: () {
                      setState(() {
                        // Rebuild widget with updated state
                        isfavorite = !isfavorite; // Toggle favorite state
                        _color = isfavorite
                            ? Colors.deepOrange
                            : Colors.grey; // Change color based on state
                      });
                    },
                    child: Icon(
                        isfavorite ? Icons.favorite : Icons.favorite_border,
                        color: _color,
                        size: 24),
                  ),*/ // Use 'favorite_border' initially)
                )
              ]),
        ));
  }
}
/*ListTile(
leading: Image(image: AssetImage(widget.image!),),
title: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

Text(
widget.mealType!,
style: TextStyle(color: Colors.cyan[600], fontSize: 18),
),
Text(widget.title!, style: TextStyle(fontSize: 18)),
//const Text("description"),
Row(children: [
Padding(
padding: const EdgeInsets.all(5.0),
child: AnimatedRatingBar(
width: 80,
initialRating: 0,
animationColor: Colors.yellow,
strokeColor: Colors.grey,
activeFillColor: Colors.deepOrange,
onRatingUpdate: (double value) {
setState(() {});
},
),
),
Text(" ${widget.calories} Calories",
style: TextStyle(
color: Colors.deepOrange, fontSize: 12)),
],),

Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Row(
children: [
Icon(Icons.access_time_outlined),
Padding(
padding: EdgeInsets.all(3.0),
child: Text(" ${widget.prepTime!} mins",
style: TextStyle(
color: Colors.grey, fontSize: 14)),
),
],
),
//SizedBox(width: 20,),
Row(
children: [
Icon(Icons.dinner_dining),
Padding(
padding: EdgeInsets.all(3.0),
child: Text(" ${widget.serving} serving",
style: TextStyle(
color: Colors.grey, fontSize: 14)),
),
],
)
],
)
],
),

trailing: IconButton(
icon: Icon(Icons.favorite,
color: _color,
size: 24), // Use 'favorite_border' initially
onPressed: () {
setState(() {
// Rebuild widget with updated state
isfavorite = !isfavorite; // Toggle favorite state
_color = isfavorite
? Colors.orange
    : Colors.grey; // Change color based on state
});
},
),
)*/
