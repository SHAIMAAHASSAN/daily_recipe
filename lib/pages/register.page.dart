import 'package:daily_recipe/pages/login.page.dart';
import 'package:daily_recipe/provider/auth.Provider.dart';
import 'package:daily_recipe/services/preference.services.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  //final username;
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
/*  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();
  late final emailController;
  late final usernameController;
  late final passwordController;*/

  @override
  void initState() {
    Provider.of<AuthProviderViewModel>(context, listen: false).initProvider();
    /* emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();*/
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Consumer<AuthProviderViewModel>(
            builder: (context, value, child) {
              return
                Form(
                  key:
                  value.formKey,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          // color: Colors.brown
                          image: DecorationImage(
                            //  opacity:.3,
                            image: AssetImage(ImagesPath.backgroundEffect),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //SizedBox(height: 10),
                            Image(
                               width: 220,
                              image: AssetImage(ImagesPath.logo),

                            ),



                            const Text(
                              'Register',
                              style: TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            const SizedBox(height: 10),

                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                      onChanged: (valid) => value.formKey?.currentState?.validate(),
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

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                      onChanged: (valid) => value.formKey?.currentState?.validate(),
                                      style: const TextStyle(
                                          color: Colors.deepOrange, fontSize: 18),
                                      controller: value.emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(

                                        prefixIcon: Icon(Icons.email_outlined),
                                        labelText: 'Email',
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      validator: (valid) {
                                        if (valid == null || valid.isEmpty) {
                                          return 'Please enter your email address.';
                                        }
                                        if (!EmailValidator.validate(valid)) {
                                          return 'Not Valid Email';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: TextFormField(
                                        onChanged: (valid) => value.formKey?.currentState?.validate(),
                                        obscureText: value.obscureText,
                                        style: const TextStyle(
                                            color: Colors.deepOrange, fontSize: 18),
                                        controller: value.passwordController,
                                        decoration: InputDecoration(

                                            labelText: 'Password',
                                            labelStyle: const TextStyle(
                                              color: Colors.white,
                                            ),
                                            prefixIcon: const Icon(
                                                Icons.lock_outline_sharp),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                value.obscureText
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                              ),
                                              onPressed: () {
                                                Provider.of<AuthProviderViewModel>(
                                                    context,
                                                    listen: false)
                                                    .toggleObsecure();
                                                /*  setState(() {
                                         obscureText = !obscureText;
                                       });*/
                                              },
                                            )),
                                        validator: (valid) {
                                          if (valid == null || valid.isEmpty) {
                                            return 'password is required';
                                          }

                                          if (valid.length < 6) {
                                            return 'password too short';
                                          }
                                          return null;
                                        }),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 200,
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(left: 10, right: 10),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.deepOrange),
                                        ),
                                        onPressed: () {
                                          // Handle button press
                                          if (value.formKey?.currentState?.validate() ??
                                              false) {

                                            value .openLoginPage(context);
                                          }
                                          // Sign up the user with Firebase Authentication.
/*
                                   GetIt.I.get<SharedPreferences>().setString("name",  usernameController.text);
                                   //PreferencService.saveUsernameData(
                                   //  usernameController.text);
                                   // Navigate to the next screen.
                                   NavigationUtils.push(context: context, page:LoginPage());*/

                                          //emailController.clear();
                                          //passwordController.clear();
                                          //  usernameController.clear();
                                          //}
                                        },
                                        child: const Text(
                                          'Register',
                                          style: TextStyle(
                                              fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //SizedBox(height: 55),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),

                     // if (MediaQuery.of(context).viewInsets.bottom == 0)
                      Positioned(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Already registered?",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      NavigationUtils.push(
                                          context: context,
                                          page: const LoginPage());
                                      /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));*/
                                    },
                                    child: const Text(
                                      "Sign in",
                                      style:
                                      TextStyle(
                                          color: Colors.deepOrange, fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      //Positioned(bottom:10,child: SizedBox(height: 10,))
                    ],
                  ),
                );
            })
    );
  }
}
