import 'package:easy_localization/easy_localization.dart';
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
          title: const Text(
            "My Kitchen",
            style: TextStyle(fontWeight: FontWeight.w500),
          ).tr(),
          backgroundColor: Colors.brown[200],
        ),
        body: Container(
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
            child: Column(
              children: [
                const SizedBox(height: 8),
                const Text(
                  "Please choose the ingredients which available in your kitchen :",
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ).tr(),
                const Divider(),
                Flexible(
                  child: Consumer<IngredientsProvider>(
                      builder: (context, valueProvider, child) => valueProvider
                                  .ingredientsList ==
                              null
                          ?  Container(
                        child: Image.asset("assets/images/loading.gif"),
                      )
                          : (valueProvider.ingredientsList?.isEmpty ?? false)
                              ? const Text('No Data Found')
                              : ListView.builder(
                                  itemCount:
                                      valueProvider.ingredientsList!.length,
                                  itemBuilder: (context, index) => ListTile(
                                      leading: Checkbox(
                                          activeColor: Colors.deepOrange,
                                          value: valueProvider
                                              .ingredientsList![index]
                                              .usersIng_ids
                                              ?.contains(FirebaseAuth
                                                  .instance.currentUser?.uid),
                                          onChanged: (value) {
                                            valueProvider.addIngredientToUser(
                                                valueProvider
                                                    .ingredientsList![index]
                                                    .docId!,
                                                value ?? false,
                                                context);
                                          }),
                                      title: Text(
                                        valueProvider
                                                .ingredientsList![index].name ??
                                            'No Name',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ).tr()
                                  ))),
                ),
              ],
            ),
          ),
        ));
  }
}
