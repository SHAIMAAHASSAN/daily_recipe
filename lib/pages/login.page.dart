import 'package:daily_recipe/pages/home.page.dart';
import 'package:daily_recipe/pages/register.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/auth.Provider.dart';
import '../services/preference.services.dart';
import '../utils/images.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 /* bool obscureText = true;
  final _formKey = GlobalKey<FormState>();
  late final emailController;

  late final passwordController;*/

  @override
  void initState() {
    Provider.of<AuthProviderViewModel>(context,listen: false).initProvider();
  /*  emailController = TextEditingController();

    passwordController = TextEditingController();*/
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: Provider.of<AuthProviderViewModel>(context,listen: false).formKey,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagesPath.backgroundEffect),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 20),
                  Image(
                    width: 250, image: AssetImage(ImagesPath.logo),
                    //   alignment: Alignment.center,
                  ),

                  /*Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Daily Recipe",
                          style: TextStyle(fontSize: 28, color: Colors.white),
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                    ],
                  ),*/
                  SizedBox(height: 10),
                  Text(
                    'Sign In',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 15),
    Consumer<AuthProviderViewModel>(builder:(context,value,child){
    return  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        onChanged: (valid) => value.formKey?.currentState?.validate(),
                        style: TextStyle(color: Colors.deepOrange, fontSize: 20),
                        controller: value.emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address.';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Not Valid Email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                          onChanged: (valid) => value.formKey?.currentState?.validate(),
                          obscureText: value.obscureText,
                          style:
                          TextStyle(color: Colors.deepOrange, fontSize: 20),
                          controller:value. passwordController,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              prefixIcon: Icon(Icons.lock_outline_sharp),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  value.obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  Provider.of<AuthProviderViewModel>(context,listen: false).toggleObsecure();
                                 /* setState(() {
                                    obscureText = !obscureText;
                                  });*/
                                },
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password is required';
                            }

                            if (value.length < 6) {
                              return 'password too short';
                            }
                            return null;
                          }),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )),
                    SizedBox(height: 10),
                    Container(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.deepOrange),
                          ),
                          onPressed: () async {
    if (value.formKey?.currentState?.validate() ?? false) {
                            value.signInUser(context);}
                            // Handle button press
                           /*
                              // Sign up the user with Firebase Authentication.
                              // await PreferencService.prefs?.setBool('isLogin', true);
                              GetIt.I.get<SharedPreferences>().setBool("isLogin", true);
                              // await PreferencService.saveLoginData(
                              //   emailController.text, passwordController.text);
                              // Navigate to the next screen.

                              NavigationUtils.push(context: context, page: HomePage());

                              //emailController.clear();
                              //passwordController.clear();
                            }*/
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],);}),

                  //SizedBox(height: 60),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Positioned(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationUtils.push(context: context, page: RegisterPage());

                      },
                      child: Text(
                        "Register",
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
