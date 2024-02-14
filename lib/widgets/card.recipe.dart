import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:daily_recipe/widgets/favorite.icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CardRecipe extends StatefulWidget {
  const CardRecipe({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<CardRecipe> createState() => _CardRecipeState();
}

class _CardRecipeState extends State<CardRecipe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20), // Adjust radius as needed
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FavoriteIcon(recipe: widget.recipe),
                Expanded(
                    child: Transform.translate(
                  offset: const Offset(4, 0),
                  child: FadeInImage(
                    image: NetworkImage(widget.recipe.image!),
                    fit: BoxFit.fitHeight,
                    width: 115,
                    height: 90,
                    placeholder: const AssetImage("assets/images/loading.gif"),
                  ),
                ))
              ],
            ),
            const SizedBox(height: 3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.recipe.mealType!,
                  style: TextStyle(color: Colors.cyan[600], fontSize: 16),
                ).tr(),
                Container(
                  width: 180,
                  child: Text(widget.recipe.title!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16))
                      .tr(),
                ),
                AnimatedRatingBar(
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
                  child: Row(
                    children: [
                      Text(" ${widget.recipe.calories}",
                          style: const TextStyle(
                              color: Colors.deepOrange, fontSize: 14)),
                      const SizedBox(
                        width: 3,
                      ),
                      const Text(" Calories",
                              style: TextStyle(
                                  color: Colors.deepOrange, fontSize: 14))
                          .tr(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_outlined,
                          size: 14,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              Text(" ${widget.recipe.prepTime!}",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              const SizedBox(
                                width: 3,
                              ),
                              const Text(" mins",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12))
                                  .tr()
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.dinner_dining,
                          size: 14,
                        ),
                        Row(
                          children: [
                            Text(" ${widget.recipe.serving}",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                            const SizedBox(
                              width: 3,
                            ),
                            const Text(" serving",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12))
                                .tr()
                          ],
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
