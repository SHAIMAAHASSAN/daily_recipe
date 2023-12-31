import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:flutter/material.dart';

class CardRecipe extends StatefulWidget {
  CardRecipe(
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
  State<CardRecipe> createState() => _CardRecipeState();
}

class _CardRecipeState extends State<CardRecipe> {
  bool isfavorite = false;
  Color _color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          width: 225,
          height: 320,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20), // Adjust radius as needed
            // border: Border.all(color: Colors.black, width: 2), // Optional border
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*IconButton(
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
                ),*/
                SizedBox(
                  height:100,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.mealType!,
                      style: TextStyle(color: Colors.cyan[600], fontSize: 18),
                    ),
                    Text(widget.title!, style: TextStyle(fontSize: 20)),
                    //const Text("description"),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: AnimatedRatingBar(
                        initialRating: 0,
                        animationColor: Colors.yellow,
                        strokeColor: Colors.grey,
                        activeFillColor: Colors.deepOrange,
                        onRatingUpdate: (double value) {
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(" ${widget.calories} Calories",
                          style: TextStyle(
                              color: Colors.deepOrange, fontSize: 16)),
                    ),
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
                )
              ],
            ),
          ),
        ),
        Positioned(
          //top: 0,
         // right: 10,
          child: Container(
            // margin: EdgeInsets.all(-20),
          // color: Colors.cyan,
            child: Row(
              children: [
               SizedBox(width: 120,),
                SizedBox(
                  child: Image(
                   // width: 250,
                    //height: 150,
                    image: AssetImage(widget.image!),
                  // fit: BoxFit.cover,
                   // alignment: Alignment.topRight,
                  ),
                 height: 150,

                  //width: 250,
                ),
              ],
            ),

          ),
        ),
        Positioned(child:IconButton(
          icon: Icon(isfavorite
              ? Icons.favorite
              : Icons.favorite_border,
              color: _color,
              size: 24), // Use 'favorite_border' initially
          onPressed: () {
            setState(() {
              // Rebuild widget with updated state
              isfavorite = !isfavorite; // Toggle favorite state
              _color = isfavorite
                  ? Colors.deepOrange
                  : Colors.grey; // Change color based on state
            });
          },
        ),)
      ],
    );
  }
}
