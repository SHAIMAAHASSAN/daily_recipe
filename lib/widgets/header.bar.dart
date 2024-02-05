
import 'package:daily_recipe/pages/view.all.recipes.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/recipes.provider.dart';
class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key,required this.title,required this.titleRight});
  final String title;
  final String titleRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title
            ,
            style:
            TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ).tr(),
          GestureDetector(

              onTap: (){
                NavigationUtils.push(context: context, page: ViewAllRecipes());
                print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhi");
              //  Provider.of<RecipesProvider>(context, listen: false).clearViewedRecipes();
              },
              child:  Text(titleRight
              ,
                style: TextStyle(color: Colors.deepOrange, fontSize: 18,fontWeight: FontWeight.w500),
              ).tr()),
        ],
      ),


    );
  }
}
