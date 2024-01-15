import 'package:daily_recipe/models/recipe.model.dart';
import 'package:daily_recipe/services/ads.services.dart';
import 'package:flutter/material.dart';
class SearchBarEX extends StatefulWidget {
  const SearchBarEX({super.key, required this.hintText});
 final String hintText;
// final bool textControllerEmpty ;

  @override
  State<SearchBarEX> createState() => _SearchBarEXState();
}

class _SearchBarEXState extends State<SearchBarEX> {
  late List<Recipe> searchedRecipes;
  List<Recipe> recipes =[];
  final searchController =TextEditingController();

  void searchedForRecipe (String searchedRecipe){
    FetchData.fetchRecipesFromJson().then((value) {
      value =recipes;
    });
    searchedRecipes= recipes.where((recipe) => recipe.title!.toLowerCase().startsWith(searchedRecipe)).toList();

    print("=================searched=$searchedRecipes");
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {


    return   Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
             controller: searchController,
              onChanged: searchedForRecipe,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                    BorderSide(color: Colors.grey.shade100)),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade100,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.tune_sharp),
            ),
          )
        ],
      ),
    );
  }
}
