import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ingredients.provider.dart';
import '../utils/images.dart';
class MyKitchenPage extends StatefulWidget {
  const MyKitchenPage({super.key});

  @override
  State<MyKitchenPage> createState() => _MyKitchenPageState();
}

class _MyKitchenPageState extends State<MyKitchenPage> {
  @override
  void initState() {
    Provider.of<IngredientsProvider>(context, listen: false).getIngredients();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("My Kitchen",style: TextStyle(fontWeight: FontWeight.w500),),
        backgroundColor: Colors.brown[200],
      ),
      body:  Container(

        decoration: BoxDecoration(
          color: Colors.black38,
          image: DecorationImage(
            image: AssetImage(ImagesPath.backgroundEffect),
            opacity: .8,
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 8),
                Text("Please choose the ingredients which avalible in your kitchen :",
                  style: TextStyle(color: Colors.deepOrange,fontSize: 20,fontWeight: FontWeight.w500
                ),),
                Divider(),
                SizedBox(height: 660,
                  child: Consumer<IngredientsProvider>(builder: (context, valueProvider, child) =>

                      valueProvider.ingredientsList == null
                      ? const CircularProgressIndicator()
                    : (valueProvider.ingredientsList?.isEmpty ?? false)
                      ? const Text('No Data Found')
                    :  ListView.builder(
                      itemCount: valueProvider.ingredientsList!.length,
                      itemBuilder: (context, index) => ListTile(
                      leading: Checkbox(
                        activeColor: Colors.deepOrange,
                      //checkColor: Colors.deepOrange,
                      value: valueProvider
                    .ingredientsList![index].usersIng_ids
                    ?.contains(FirebaseAuth
                    .instance.currentUser?.uid),
                      onChanged: (value) {
                      valueProvider.addIngredientToUser(
                      valueProvider
                    .ingredientsList![index].docId!,
                      value ?? false,context);
                      }),
                      title: Text(valueProvider
                    .ingredientsList![index].name ??
                      'No Name',style: TextStyle(color: Colors.white,fontSize: 20),)))),
                ),
              ],
            ),
          ),
        ),
      )



    );
  }
}
