import 'package:daily_recipe/pages/profile.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:flutter/material.dart';

import '../widgets/header.bar.dart';
import 'notification.page.dart';
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
          HeaderBar(title: "Settings", titleRight: ""),

              SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.language_sharp),
                title: Text("Language"),
                trailing:  Text("English",style: TextStyle(color: Colors.deepOrange,fontSize: 14),),
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
               HeaderBar(title: "Profile", titleRight:""),
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
