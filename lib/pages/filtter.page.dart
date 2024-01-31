import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:daily_recipe/widgets/chip.widget.dart';
import 'package:daily_recipe/widgets/filtter.recipes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/recipes.provider.dart';
class FiltterPage extends StatefulWidget {
  const FiltterPage({super.key});

  @override
  State<FiltterPage> createState() => _FiltterPageState();
}

class _FiltterPageState extends State<FiltterPage> {
  Map<String,dynamic> selectedUserValue = {};
  late final servingController;
  late final prepTimeController;
  late final caloriesController;

  @override
  void initState() {
    servingController=TextEditingController();
    prepTimeController=TextEditingController();
    caloriesController=TextEditingController();
    Provider.of<RecipesProvider>(context, listen: false).getFilteredResult(selectedUserValue);


    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Meal",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
              SizedBox(height: 10,),
              Wrap(
                // space between chips
                  spacing: 20,
                  // list of chips
                  children: [
                  /*  ChipWidget(mealType: "BREAKFAST"),
                    ChipWidget(mealType: "DINNER"),
                    ChipWidget(mealType: "SOUP"),
                    ChipWidget(mealType: "SALAD"),
                    ChipWidget(mealType: "HEALTHY"),
                    ChipWidget(mealType: "DESSERT"),
                    ChipWidget(mealType: "QUICK&EASY"),*/
                    InkWell(
                      onTap: () {
                        selectedUserValue['meal_type'] = "BREAKFAST";
                        setState(() {});
                      },
                      child: Chip(
                        label: Text('BREAKFAST',style: TextStyle(color:/*selectedUserValue['type'] == "BREAKFAST"
                            ? Colors.white
                            :*/ Colors.black54, ),),
                        backgroundColor: selectedUserValue['meal_type'] == "BREAKFAST"
                            ? Colors.deepOrange
                            : Colors.grey[200],
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        selectedUserValue['meal_type'] = "DINNER";
                        setState(() {});
                      },
                      child: Chip(
                        label: Text('DINNER',style: TextStyle(color:/*selectedUserValue['type'] == "BREAKFAST"
                            ? Colors.white
                            :*/ Colors.black54, )),
                        backgroundColor: selectedUserValue['meal_type'] == "DINNER"
                            ? Colors.deepOrange
                            : Colors.grey[200],
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        selectedUserValue['meal_type'] = "SOUP";
                        setState(() {});
                      },
                      child: Chip(
                        label: Text('SOUP',style: TextStyle(color:/*selectedUserValue['type'] == "BREAKFAST"
                            ? Colors.white
                            :*/ Colors.black54, )),
                        backgroundColor: selectedUserValue['meal_type'] == "SOUP"
                            ? Colors.deepOrange
                            : Colors.grey[200],
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        selectedUserValue['meal_type'] = "SALAD";
                        setState(() {});
                      },
                      child: Chip(
                        label: Text('SALAD',style: TextStyle(color:/*selectedUserValue['type'] == "BREAKFAST"
                            ? Colors.white
                            :*/ Colors.black54, )),
                        backgroundColor: selectedUserValue['meal_type'] == "SALAD"
                            ? Colors.deepOrange
                            : Colors.grey[200],
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        selectedUserValue['meal_type'] = "DESSERT";
                        setState(() {});
                      },
                      child: Chip(
                        label: Text('DESSERT',style: TextStyle(color:/*selectedUserValue['type'] == "BREAKFAST"
                            ? Colors.white
                            : */Colors.black54, )),
                        backgroundColor: selectedUserValue['meal_type'] == "DESSERT"
                            ? Colors.deepOrange
                            : Colors.grey[200],
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        selectedUserValue['meal_type'] = "HEALTHY";
                        setState(() {});
                      },
                      child: Chip(
                        label: Text('HEALTHY',style: TextStyle(color:/*selectedUserValue['type'] == "BREAKFAST"
                            ? Colors.white
                            :*/ Colors.black54, )),
                        backgroundColor: selectedUserValue['meal_type'] == "HEALTHY"
                            ? Colors.deepOrange
                            : Colors.grey[200],
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        selectedUserValue['meal_type'] = "QUICK&EASY";
                        setState(() {});
                      },
                      child: Chip(
                        label: Text('QUICK&EASY',style: TextStyle(color:/*selectedUserValue['type'] == "BREAKFAST"
                            ? Colors.white
                            :*/ Colors.black54, )),
                        backgroundColor: selectedUserValue['meal_type'] == "QUICK&EASY"
                            ? Colors.deepOrange
                            : Colors.grey[200],
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                    ),
          
          
                  ]),
              Divider(),
              SizedBox(height: 10,),
              Text("Serving",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("Enter number of serving :",style: TextStyle(color: Colors.deepOrange,fontSize: 18),),
                  SizedBox(width: 20,),
                  SizedBox(
                    height: 10,
                    width: 30,
                    child: TextFormField(
                      // onChanged: (valid) => value.formKey?.currentState?.validate(),
                      controller: servingController,
                      decoration: InputDecoration(
                       // prefixIcon: Icon(Icons.email_outlined),
                        //labelText: 'Enter number of serving',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
          
                    ),
                  ),
                ],),
              SizedBox(height: 5,),
              Divider(),
              SizedBox(height: 10,),
              Text("Preparation Time",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("Enter Preparation Time :",style: TextStyle(color: Colors.deepOrange,fontSize: 18),),
                  SizedBox(width: 20,),
                  SizedBox(
                    height: 10,
                    width: 30,
                    child: TextFormField(
                      // onChanged: (valid) => value.formKey?.currentState?.validate(),
                      controller:prepTimeController ,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.email_outlined),
                        //labelText: 'Enter number of serving',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
          
                    ),
                  ),
                ],),
              SizedBox(height: 5,),
              Divider(),
              SizedBox(height: 10,),
              Text("Calories",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("Enter Calories numbers :",style: TextStyle(color: Colors.deepOrange,fontSize: 18),),
                  SizedBox(width: 20,),
                  SizedBox(
                    height: 10,
                    width: 40,
                    child: TextFormField(
                      // onChanged: (valid) => value.formKey?.currentState?.validate(),
                      controller:caloriesController ,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.email_outlined),
                        //labelText: 'Enter number of serving',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
          
                    ),
                  ),
                ],),
              SizedBox(height: 5,),
              Divider(),
          
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.deepOrange),
                      ),
                      onPressed: () async {
          
                        selectedUserValue['serving'] = servingController.text;
                        selectedUserValue['prep_time'] =prepTimeController.text;
                        selectedUserValue['calories']=caloriesController.text;

                        NavigationUtils.push(context: context, page: FiltterRecipes(valueselected: selectedUserValue));
          
                        print("kkkkkkkkkkkkkkkkkkkkkkkkkkSelectedUsers$selectedUserValue kkkkkkkkkkkkkkkkkkkkkkkkkkk");

                      /*  servingController.Clear();
                        prepTimeController.Clear();
                        caloriesController.Clear();*/

                        //   if (value.formKey?.currentState?.validate() ?? false) {
          
                        //  }
          
                      },
                      child: Text(
                        'Apply' ,
                        style: TextStyle(
                            fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
