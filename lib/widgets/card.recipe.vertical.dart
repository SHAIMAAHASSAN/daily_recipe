import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:flutter/material.dart';

class CardRecipeVertical extends StatefulWidget {
  CardRecipeVertical(
      {super.key,
      required this.mealType,
      required this.title,
      required this.image,
      required this.calories,
      required this.prepTime,
      required this.serving});
  String? mealType;
  String? title;
  //String? description;
  String? image;
  // int? rating;
  int? prepTime;
  int? serving;
  double? calories;

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
          padding: const EdgeInsets.all(4.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
            Image(
              image: AssetImage(widget.image!),
              width: 95,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.mealType!,
                  style: TextStyle(color: Colors.cyan[600], fontSize: 16),
                ),
                Text(widget.title!, style: TextStyle(fontSize: 16)),
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
                    Text(" ${widget.calories} Calories",
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 14)),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time_outlined),
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(" ${widget.prepTime!} mins",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Row(
                      children: [
                        Icon(Icons.dinner_dining),
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(" ${widget.serving} serving",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(     isfavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                      color: _color, size: 24), // Use 'favorite_border' initially
                  onPressed: () {
                    setState(() {
// Rebuild widget with updated state
                      isfavorite = !isfavorite; // Toggle favorite state
                      _color = isfavorite
                          ? Colors.deepOrange
                          : Colors.grey; // Change color based on state
                    });
                  },
                ),
              ),
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
