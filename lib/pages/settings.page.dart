import 'package:daily_recipe/pages/profile.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/utils/localization.checker.utils.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

import '../provider/local.model.provider.dart';
import '../widgets/header.bar.dart';
import 'notification.page.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  void initState() {
   //   changeLanguge(context);
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SideMenuPage(),
                    ));
              },
              icon: Icon(Icons.sort)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationPage(),
                      ));
                },
                icon: Icon(Icons.notifications)),
          ]),
      body:  SafeArea(child:
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          HeaderBar(title: "Settings" .tr(), titleRight: ""),

              SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.language_sharp),
                title: Text("Language"),
                trailing:  InkWell(
                    onTap: (){

                      Dialogs.materialDialog(
                          msg: 'Select your favorites language',
                          title: "Set language",
                          color: Colors.white,
                          context: context,
                          actions: [
                            IconsOutlineButton(
                              onPressed: () {
                                Provider.of<LocaleModel>(context,listen: false).setLocale(Locale('ar', 'EG'),context);
                              },
                              text: 'Arabic',

                              //iconData: Icons.cancel_outlined,
                              textStyle: TextStyle(color: Colors.grey),
                              iconColor: Colors.grey,
                            ),
                            IconsButton(
                              onPressed: () {
                                Provider.of<LocaleModel>(context,listen: false).setLocale(Locale('en', 'US'),context);
                              },
                              text: 'English',
                              //iconData: Icons.delete,
                              color: Colors.red,
                              textStyle: TextStyle(color: Colors.white),
                              iconColor: Colors.white,
                            ),
                          ]);
                      /*showModalBottomSheet(
                        context: context,
                        constraints: BoxConstraints.expand(
                          width: MediaQuery.of(context).size.width * .5, // 80% width
                          height: 100, // Fixed height
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Provider.of<LocaleModel>(context,listen: false).setLocale(Locale('en', 'US'),context);
                                 *//* setState(() {
                                    EasyLocalization.of(context)!.setLocale(const Locale('en', 'US'));
                                  });*//*


                                },
                                child: Text(
                                  'English (United States)',

                                ),
                              ),
                              SizedBox(height: 10,),
                              InkWell(
                                onTap: (){
                                  Provider.of<LocaleModel>(context,listen: false).setLocale(Locale('ar', 'EG'),context);
                                *//* setState(() {
                                   EasyLocalization.of(context)!.setLocale(const Locale('ar', 'EG'));
                                 });*//*
                                },
                                child: Text(
                                  'العربية',

                                ),
                              ),
                            ],
                          ),
                        ),
                      );*/
                     /*setState(() {
                       LocalizationChecker.changeLanguge(context);

                     });*/
                    },
                    child: const Text("Set language",style: TextStyle(color: Colors.deepOrange,fontSize: 14),)),
                tileColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade100, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 15),
              child: Divider(),
            ),
               HeaderBar(title: "Profile".tr(), titleRight:""),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                NavigationUtils.push(context: context, page: ProfilePage());
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: InkWell(
                    onTap: (){
                      NavigationUtils.push(context: context, page: ProfilePage());
                    },
                    child: Text("Edit Profile")),
                //trailing:  Text("English",style: TextStyle(color: Colors.deepOrange,fontSize: 14),),
                tileColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade100, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

        ],
        ),
      ),
      ),
    )
      ;
  }
}
