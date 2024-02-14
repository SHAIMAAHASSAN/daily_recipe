import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth.Provider.dart';
import '../utils/images.dart';
import '../utils/toast.message.utils.dart';
import '../utils/toast.status.dart';
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
    // TODO: implement initState
    super.initState();
  }

  Future<void> updateProfile() async {
    await Future.delayed(const Duration(milliseconds: 10));
    if (context.mounted) {
      Provider.of<AuthProviderViewModel>(context, listen: false).initUpdate();
    }
  }

  String image =
      "https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Profile",
              style: TextStyle(fontWeight: FontWeight.w500),
            ).tr(),
            backgroundColor: Colors.brown[100],
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SideMenuPage(),
                      ));
                },
                icon: const Icon(Icons.sort)),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationPage(),
                        ));
                  },
                  icon: const Icon(Icons.notifications)),
            ]),
        body: Form(
          key: Provider.of<AuthProviderViewModel>(context).updateProfileFormKey,
          child: Column(
            children: [
              /*  SizedBox(height: 30,),
            AppBarWidget(title: "Profile",color: Colors.black,),*/
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      opacity: .5,
                      image: AssetImage(ImagesPath.backgroundEffect),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Consumer<AuthProviderViewModel>(
                      builder: (context, value, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              value.photo != null

                                  ? CircleAvatar(
                                      radius: 60,
                                      backgroundImage:
                                          NetworkImage(value.photo!))
                                  : CircleAvatar(
                                      radius: 60,
                                      backgroundImage: NetworkImage(image)),
                              Positioned(
                                  bottom: -2,
                                  right: 10,
                                  child: InkWell(
                                    onTap: () async {
                                      await Provider.of<AuthProviderViewModel>(
                                              context,
                                              listen: false)
                                          .updateImageProfile();
                                    },
                                    child: const Icon(
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
                            // onChanged: (valid) => value
                            //   .updateProfileFormKey?.currentState
                            // ?.validate(),
                            style: const TextStyle(
                                color: Colors.deepOrange, fontSize: 18),
                            controller: value.usernameController,
                            decoration:  InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: 'User name'.tr(),
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
                          padding: const EdgeInsets.only(
                              bottom: 5, right: 10, left: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            //onChanged: (valid) =>
                            //value.updateProfileFormKey?.currentState?.validate(),
                            style: const TextStyle(
                                color: Colors.deepOrange, fontSize: 18),
                            controller: value.phoneController,
                            decoration:  InputDecoration(
                              prefixText: "+2",
                              prefixStyle: TextStyle(
                                  color: Colors.deepOrange, fontSize: 18),
                              prefixIcon: Icon(Icons.phone_android),
                              //hintText: "+20xxxxxxxxxx",
                              labelText: 'Phone Number'.tr(),
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
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: const Text(
                                  "Send OTP",
                                  style: TextStyle(color: Colors.deepOrange),
                                ),
                                onTap: () {
                                  value.sentOtp(
                                      phone: value.phoneController!.text,
                                      errorStep: () =>
                                          ToastMessageUtils.showToastMessage(
                                              context,
                                              ToastStatus.failed,
                                              "Error in sending OTP"),
                                      nextStep: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: const Text(
                                                      "OTP Verification"),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 12,
                                                      ),
                                                      Form(
                                                        key: value.otpFormKey,
                                                        child: TextFormField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller: value
                                                              .otpController,
                                                          decoration: InputDecoration(
                                                              labelText:
                                                                  "Enter the code that sent SMS",
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              32))),
                                                          validator: (value) {
                                                            if (value!.length !=
                                                                6) {
                                                              return "Invalid OTP";
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          value.updatePhoneNumber(
                                                              context,
                                                              value
                                                                  .otpController!
                                                                  .text);
                                                        },
                                                        child: const Text(
                                                            "Submit"))
                                                  ],
                                                ));
                                      });
                                },
                              ),
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .75,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.deepOrange),
                              ),
                              onPressed: () async {
                                value.updateName(context);
                              },
                              child: const Text(
                                'Update Profile',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ).tr(),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ));
  }
}
