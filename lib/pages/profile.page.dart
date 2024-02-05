import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth.Provider.dart';
import '../utils/images.dart';
import '../utils/toast.status.dart';
import '../widgets/toast.message.dart';
import 'notification.page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    updateProfile();
    // Provider.of<AuthProviderViewModel>(context, listen: false).initProvider();
    // TODO: implement initState
    super.initState();
  }

  Future<void> updateProfile() async {
    await Future.delayed(const Duration(milliseconds: 10));
   // Provider.of<AuthProviderViewModel>(context, listen: false).updateImageProfile();
    Provider.of<AuthProviderViewModel>(context, listen: false).initUpdate();
  }

 // String? photo = FirebaseAuth.instance.currentUser!.photoURL;

  String image =
      "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg";
  @override
  Widget build(BuildContext context) {
    print("====================photo=${Provider.of<AuthProviderViewModel>(context, listen: false).photo}=============================");
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
        body: Form(
          key: Provider.of<AuthProviderViewModel>(context).updateProfileFormKey,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: .5,
                image: AssetImage(ImagesPath.backgroundEffect),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(child:
                Consumer<AuthProviderViewModel>(builder: (context, value, child) {
              return  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Stack(
                          children: [


                           value. photo != null

                                // _profileImage != null
                                ? CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(value.photo!))
                               : CircleAvatar(
                                        radius: 70,
                                        backgroundImage: NetworkImage(image)),

                            /*CircleAvatar(
                              radius: 40,
                              backgroundImage:NetworkImage(image)
                              //NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),

                            ),*/
                            Positioned(
                                bottom: -2,
                                right: 10,
                                child: InkWell(
                                  onTap: () async {
                                    /*Provider.of<AuthProviderViewModel>(context,
                                            listen: false)*/

                                    print(
                                        " ================photo before update =${value.photo} ========================");
                                    await  Provider.of<AuthProviderViewModel>(context
                                       ,listen: false ).updateImageProfile();
                                    // value.downloadURL=FirebaseAuth.instance.currentUser!.photoURL;

                                   //photo = FirebaseAuth.instance.currentUser!.photoURL;
                                    print(
                                        " ================photo after update =${value.photo} ========================");
                                  },
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 30,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextFormField(
                          onChanged: (valid) => value
                              .updateProfileFormKey?.currentState
                              ?.validate(),
                          style: const TextStyle(
                              color: Colors.deepOrange, fontSize: 18),
                          controller: value.usernameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'User name',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          validator: (valid) {
                            if (valid == null || valid.isEmpty) {
                              print("Please enter your name.");
                              return 'Please enter your name.';
                            }
                            return null;
                          },
                        ),
                      ),
                      /*Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: (valid) => value.formKey?.currentState?.validate(),
                          style:
                              const TextStyle(color: Colors.deepOrange, fontSize: 18),
                          controller: value.usernameController,

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
                            if (valid == null || valid.isEmpty) {
                              print("Please enter your name.");
                              return 'Please enter your name.';
                            }
                            return null;
                          }
                          }
                        ),
                      ),*/
                      /*  Padding(
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
                      ),*/
                      SizedBox(height: 20),
                      Container(
                        width: 250,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepOrange),
                            ),
                            onPressed: () async {
                              value.updateName(context);


                           /*   print(
                                  "objectttttttttttttttttttttttttttt ${value.updateProfileFormKey?.currentState?.validate()}tttttttttttttttttttttt");

                              print(
                                  "=============================${value.usernameController!.text}===========");


                                print(
                                    "*********************controller=${value.usernameController!.text}");
                                print("===============================username="
                                    "${FirebaseAuth.instance.currentUser!.displayName}================== ");
                                //  await value.updatePhoneNumber();

                                print(
                                    "uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");


                              print(
                                  "falseeeeeeeeeeeeeeeeeee  Unvalidate  eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");*/
                            },
                            child: Text(
                              'Update Profile',
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],


              );
            })),
          ),
        ));
  }
}
