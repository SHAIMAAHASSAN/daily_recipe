import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth.Provider.dart';
import '../utils/images.dart';
import 'notification.page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    Provider.of<AuthProviderViewModel>(context, listen: false).updateProfile();
    Provider.of<AuthProviderViewModel>(context, listen: false).initProvider();
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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              opacity: .5,
              image: AssetImage(ImagesPath.backgroundEffect),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(child:
              Consumer<AuthProviderViewModel>(builder: (context, value, child) {
            return Form(
              key: value
                  .updateProfileFormKey,
              child: Container(
               /* decoration: BoxDecoration(
                  image: DecorationImage(
                    opacity: .5,
                    image: AssetImage(ImagesPath.backgroundEffect),
                    fit: BoxFit.cover,
                  ),
                ),*/
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                FirebaseAuth.instance.currentUser!.photoURL!),
                          ),
                          Positioned(
                              bottom: 0,
                              right: -0,
                              child: InkWell(
                                onTap: () {
                                  Provider.of<AuthProviderViewModel>(context,
                                          listen: false)
                                      .updateProfile();
                                },
                                child: Icon(Icons.add_a_photo_outlined),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        onChanged: (valid) => value.updateProfileFormKey?.currentState?.validate(),
                        style:
                            const TextStyle(color: Colors.deepOrange, fontSize: 18),
                        controller: value
                            .updateUsernameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'User name',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        validator: (valid) {
                          if (valid!.isEmpty ||
                              !RegExp(r'^[a-zA-Z ]+$').hasMatch(valid)) {
                            print("Please enter your name.");
                            return 'Please enter your name.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0,right: 10,left: 10),
                      child: TextFormField(
                        onChanged: (valid) => value.updateProfileFormKey?.currentState?.validate(),
                        style:
                        const TextStyle(color: Colors.deepOrange, fontSize: 18),
                        controller: value
                            .phoneController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone_android),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        validator: (valid) {
                          if (valid!.isEmpty ||
                              !RegExp(r'^(02|010|011|012|015)\d{8}$')
                                  .hasMatch(valid)) {
                            print("Please enter your Phone Number.");
                            return 'Please enter your Phone Number.';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(
                                Colors.deepOrange),
                          ),
                          onPressed: () async {

                              if (value.updateProfileFormKey?.currentState?.validate() ?? false) {

                                FirebaseAuth.instance.currentUser!
                                    .updateDisplayName(value.updateUsernameController!.text);
                                print("*********************controller=${value.updateUsernameController!.text}");
                                print("===============================username="
                                    "${ FirebaseAuth.instance.currentUser!.displayName}================== ");
                            //  await value.updatePhoneNumber();
                                Navigator.pop(context);
                               print("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");


                              }

                             // print("falseeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");

                          },
                          child: Text(
                            'Update Profile' ,
                            style: TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            );
          })),
        ));
  }
}
