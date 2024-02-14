import 'package:animated_rating_bar/widgets/animated_rating_bar.dart';
import 'package:daily_recipe/models/recipe.model.dart';
import 'package:daily_recipe/widgets/favorite.icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CardRecipeVertical extends StatefulWidget {
  const CardRecipeVertical({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<CardRecipeVertical> createState() => _CardRecipeVerticalState();
}

class _CardRecipeVerticalState extends State<CardRecipeVertical> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(right: 8.0, left: 4, top: 8, bottom: 8),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: SizedBox(
                    width: 90,
                    height: 90,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, right: 8, left: 4),
                      child: FadeInImage(
                        placeholder:
                            const AssetImage("assets/images/loading.gif"),
                        image: NetworkImage(widget.recipe.image!),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.recipe.mealType!,
                      style: TextStyle(color: Colors.cyan[600], fontSize: 16),
                    ).tr(),
                    SizedBox(
                      width: 170,
                      child: Text(
                        widget.recipe.title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ).tr(),
                    ),
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
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Text(" ${widget.recipe.calories}",
                                style: const TextStyle(
                                    color: Colors.deepOrange, fontSize: 12)),
                            const SizedBox(
                              width: 3,
                            ),
                            const Text(" Calories",
                                    style: TextStyle(
                                        color: Colors.deepOrange, fontSize: 12))
                                .tr(),
                          ],
                        ),
                      ],
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
                            Row(
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
                          ],
                        ),
                        const SizedBox(
                          width: 22,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.dinner_dining,
                              size: 14,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
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
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                FavoriteIcon(recipe: widget.recipe),
              ]),
        ));
  }
}
