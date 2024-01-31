import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:daily_recipe/pages/recipe.view.page.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:daily_recipe/widgets/favorite.icon.dart';
import 'package:flutter/material.dart';

class CardRecipe extends StatefulWidget {
  CardRecipe({
    super.key,required this.recipe
   /* required this.mealType,
    required this.title,
    required this.image,
    required this.calories,
    required this.prepTime,
    required this.serving,
    //required this.favorite,
    required this.currentIndex*/,
  });

  Recipe recipe;
 /* String? mealType;
  String? title;
  //String? description;
  String? image;
  // int? rating;
  int? prepTime;
  int? serving;
  int? calories;
  List<dynamic> ingredients = [];
  int currentIndex ;*/
  //bool favorite = false;

  @override
  State<CardRecipe> createState() => _CardRecipeState();
}

class _CardRecipeState extends State<CardRecipe> {
  bool isfavorite = false;
  Color _color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      //height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20), // Adjust radius as needed
        // border: Border.all(color: Colors.black, width: 2), // Optional border
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                FavoriteIcon(recipe: widget.recipe),
              /*  GestureDetector(
                  onTap: () {
                    setState(() {
                      // Rebuild widget with updated state
                      isfavorite = !isfavorite; // Toggle favorite state
                      _color = isfavorite
                          ? Colors.deepOrange
                          : Colors.grey; // Change color based on state
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(
                        isfavorite ? Icons.favorite : Icons.favorite_border,
                        color: _color,
                        size: 25),
                  ),
                ),*/
                Container(
                    // color: Colors.cyan,

                    child: Transform.translate(
                  offset: Offset(2, 0),
                  child: FadeInImage(
                    fadeInDuration: Duration(seconds: 3),
                    fadeInCurve: Curves.easeIn, // Apply the ease-in curve

                    image: NetworkImage(widget.recipe.image!),
                    fit: BoxFit.fitHeight,
                    width: 118,
                    height: 100,
                    placeholder: AssetImage("assets/images/loading.gif"),
                  ),

                  // ),

                  /*Image(
                       width:200,
                      height: 130,

                      image:  NetworkImage(
                          widget.image!),
                        fit: BoxFit.fitHeight

                    ),*/
                ) // Use 'favorite_border' initially)

                    )
              ],
            ),
            // SizedBox(
            //  height: 100,
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.recipe.mealType!,
                  style: TextStyle(color: Colors.cyan[600], fontSize: 16),
                ),
                Container(width: 180,
                  child: Text(widget.recipe.title!,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                ),
                //const Text("description"),
                AnimatedRatingBar(
                  //height: 35,
                  initialRating: 0,
                  animationColor: Colors.yellow,
                  strokeColor: Colors.grey,
                  activeFillColor: Colors.deepOrange,
                  onRatingUpdate: (double value) {
                    setState(() {});
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(" ${widget.recipe.calories} Calories",
                      style: TextStyle(color: Colors.deepOrange, fontSize: 12)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.access_time_outlined,size: 14,),
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(" ${widget.recipe.prepTime!} mins",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                        ),
                      ],
                    ),
                    //SizedBox(width: 20,),
                    Row(
                      children: [
                        Icon(Icons.dinner_dining,size: 14,),
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(" ${widget.recipe.serving} serving",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
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
    );
  }
}

/*
Stack(
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
                  height: 100,
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
                SizedBox(
                  width: 120,
                ),
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
        Positioned(
          child: GestureDetector(
            onTap: () {
              setState(() {
                // Rebuild widget with updated state
                isfavorite = !isfavorite; // Toggle favorite state
                _color = isfavorite
                    ? Colors.deepOrange
                    : Colors.grey; // Change color based on state
              });
            },
            child: Icon(isfavorite ? Icons.favorite : Icons.favorite_border,
                color: _color, size: 24),
          ), // Use 'favorite_border' initially)
        )
      ],
    );*/
