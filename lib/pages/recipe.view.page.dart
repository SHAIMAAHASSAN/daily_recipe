import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:daily_recipe/provider/home.view.model.dart';
import 'package:daily_recipe/widgets/bottom.sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/favorite.icon.dart';
class RecipeViewPage extends StatelessWidget {
  RecipeViewPage( {super.key,
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
  int? calories;


  @override
  Widget build(BuildContext context) {

    List<String> ingredients = [
      "assets/images/eggs.jpg",
      "assets/images/butter.jpg",
       "assets/images/blueberries.jpg",
    "assets/images/strawberry.jpg",
       "assets/images/flour.jpg",
      "assets/images/water.jpg"

    ];
    return Scaffold(body: SafeArea(
      child: Container(
          color: Colors.grey[200],
          child: Stack(
            children:[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( mealType!, style: TextStyle(color: Colors.cyan[600], fontSize: 16),),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Text( title!,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),
                          FavoriteIcon(),
                        ] ),
                    Text(" ${calories} Calories",
                        style: TextStyle(
                            color: Colors.deepOrange, fontSize: 14)),
                    AnimatedRatingBar(
                      //height: 35,
                      initialRating: 0,
                      animationColor: Colors.yellow,
                      strokeColor: Colors.grey,
                      activeFillColor: Colors.deepOrange,
                      onRatingUpdate: (double value) {
                        // setState(() {});
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.access_time_outlined),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(" ${prepTime!} mins",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14)),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Icon(Icons.dinner_dining),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(" ${serving} serving",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14)),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          // color: Colors.cyan,
                            child: Transform.translate(
                              offset: Offset(30,0),
                              child: Image(
                                width:200,
                                height: 130,
                                image: AssetImage(
                                    image!),
                                // fit: BoxFit.fitHeight
                              ),
                            ) // Use 'favorite_border' initially)

                        )
                      ],
                    ),

                    Text( "Ingredients",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...ingredients.map((e) {

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image(
                                width:80,
                                height: 80,
                                image: AssetImage(
                                    e),
                                // fit: BoxFit.fitHeight
                              ),
                            );
                          }).toList()
                        ],
                      ),
                    ),
                    /*Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () => showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible:false,
                          context: context,
                          builder: (context) => BuildBottomSheet(),
                        ),
                        child: Text('Directions'),
                      ),
                    )*/

                  ],
                ),
              ),
              Align(alignment: Alignment.bottomCenter,
                  child: BuildBottomSheet())
            ]
          ),

        ),
    ),
    );
  }
}
