import 'package:daily_recipe/pages/view.all.recipes.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key, required this.title, required this.titleRight});
  final String title;
  final String titleRight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ).tr(),
        GestureDetector(
            onTap: () {
              NavigationUtils.push(
                  context: context, page: const ViewAllRecipes());
            },
            child: Text(
              titleRight,
              style: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ).tr()),
      ],
    );
  }
}
