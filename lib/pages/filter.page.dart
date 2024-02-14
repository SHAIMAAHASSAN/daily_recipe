import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:daily_recipe/widgets/chip.widget.dart';
import 'package:daily_recipe/widgets/filtter.recipes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'notification.page.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  Map<String, dynamic> selectedUserValue = {};
  // late final servingController;
  // late final prepTimeController;
  // late final caloriesController;
  late double servingValue;
  late double prepTimeValue;
  late double caloriesValue;

  @override
  void initState() {
    servingValue = 0;
    prepTimeValue = 0;
    caloriesValue = 0;
    onSelect(selectedUserValue);
    // TODO: implement initState
    super.initState();
  }

  void onSelect(newValue) {
    setState(() {
      selectedUserValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                NavigationUtils.push(
                    context: context, page: const SideMenuPage());
              },
              icon: const Icon(Icons.sort)),
          actions: [
            IconButton(
                onPressed: () {
                  NavigationUtils.push(
                      context: context, page: const NotificationPage());
                },
                icon: const Icon(Icons.notifications)),
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Filter",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ).tr(),
                    InkWell(
                      onTap: () {
                        selectedUserValue = {};
                        servingValue = 0;
                        prepTimeValue = 0;
                        caloriesValue = 0;
                        setState(() {});
                      },
                      child: const Text(
                        "Reset",
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ).tr(),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Meal",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ).tr(),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                  // space between chips
                  spacing: 20,
                  // list of chips
                  children: [
                    ChipWidget(
                      mealType: "BREAKFAST".tr(),
                      selectedUserValue: selectedUserValue,
                      onSelect: onSelect,
                    ),
                    ChipWidget(
                      mealType: "DINNER".tr(),
                      selectedUserValue: selectedUserValue,
                      onSelect: onSelect,
                    ),
                    ChipWidget(
                        mealType: "SOUP".tr(),
                        selectedUserValue: selectedUserValue,
                        onSelect: onSelect),
                    ChipWidget(
                        mealType: "SALAD".tr(),
                        selectedUserValue: selectedUserValue,
                        onSelect: onSelect),
                    ChipWidget(
                        mealType: "HEALTHY".tr(),
                        selectedUserValue: selectedUserValue,
                        onSelect: onSelect),
                    ChipWidget(
                      mealType: "DESSERT".tr(),
                      selectedUserValue: selectedUserValue,
                      onSelect: onSelect,
                    ),
                    ChipWidget(
                      mealType: "QUICK&EASY".tr(),
                      selectedUserValue: selectedUserValue,
                      onSelect: onSelect,
                    ),
                    ChipWidget(
                      mealType: "VEGETARIAN".tr(),
                      selectedUserValue: selectedUserValue,
                      onSelect: onSelect,
                    ),
                  ]),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Serving",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ).tr(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "Select number of serving :",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 18),
                  ).tr(),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(servingValue.round().toString()),

                  /*SizedBox(
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
                  ),*/
                ],
              ),
              //slider serving
              Slider(
                value: servingValue.roundToDouble(),
                min: 0,
                max: 10,
                divisions: 10,
                activeColor: Colors.deepOrange,
                label: servingValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    servingValue = value;
                  });
                },
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Preparation Time",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ).tr(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "Select Preparation Time :",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 18),
                  ).tr(),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(prepTimeValue.round().toString() + " mins".tr()),

                  //set Manually
                  /*SizedBox(
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
                  ),*/
                ],
              ),
              //slider preparation time
              Slider(
                value: prepTimeValue.roundToDouble(),
                min: 0,
                max: 100,
                divisions: 20,
                activeColor: Colors.deepOrange,
                label: prepTimeValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    prepTimeValue = value;
                  });
                },
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Calories",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ).tr(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "Select Calories numbers :",
                    style: TextStyle(color: Colors.deepOrange, fontSize: 18),
                  ).tr(),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(caloriesValue.round().toString() + " Cal.".tr()),
                  /* SizedBox(
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
                  ),*/
                ],
              ),
              //Slider Calories
              Slider(
                value: caloriesValue.roundToDouble(),
                min: 0,
                max: 800,
                divisions: 400,
                activeColor: Colors.deepOrange,
                label: caloriesValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    caloriesValue = value;
                  });
                },
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),

              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.deepOrange),
                      ),
                      onPressed: () async {
                        selectedUserValue['serving'] =
                            servingValue.round().toInt();
                        selectedUserValue['prep_time'] =
                            prepTimeValue.round().toInt();
                        selectedUserValue['calories'] =
                            caloriesValue.round().toInt();

                        NavigationUtils.push(
                            context: context,
                            page: FilterRecipes(
                                valueSelected: selectedUserValue));

                        /*  servingController.Clear();
                        prepTimeController.Clear();
                        caloriesController.Clear();*/
                      },
                      child: const Text(
                        "Apply",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ).tr(),
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

  @override
  void dispose() {
    servingValue = 0;
    prepTimeValue = 0;
    caloriesValue = 0;
    // servingController =null;
    // prepTimeController=null;
    //  caloriesController=null;
    // TODO: implement dispose
    super.dispose();
  }
}
