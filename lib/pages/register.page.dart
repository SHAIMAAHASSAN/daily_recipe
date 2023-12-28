import 'package:daily_recipe/pages/login.page.dart';
import 'package:daily_recipe/services/preference.services.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  //final username;
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool obscureText = true;
  final _formKey = GlobalKey<FormState>();
  late final emailController;
  late final usernameController;
  late final passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
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
                    width: 250, image: AssetImage(ImagesPath.logo),
                    // alignment: Alignment.center,
                  ),

                  /* Row(
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
                    'Register',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 20),
                            controller: usernameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: 'User name',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 20),
                            controller: emailController,
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
                              obscureText: obscureText,
                              style: TextStyle(
                                  color: Colors.deepOrange, fontSize: 20),
                              controller: passwordController,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  prefixIcon: Icon(Icons.lock_outline_sharp),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
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
                        SizedBox(height:15),
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
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  // Sign up the user with Firebase Authentication.
                                  PreferencService.saveUsernameData(
                                      usernameController.text);
                                  // Navigate to the next screen.
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ));
                                  //emailController.clear();
                                  //passwordController.clear();
                                  //  usernameController.clear();
                                }
                              },
                              child: Text(
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
                  )
                ],
              ),
            ),
            Positioned(

                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Already registered?",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                          },
                          child: Text(
                            "Sign in",
                            style:
                                TextStyle(color: Colors.deepOrange, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            //Positioned(bottom:10,child: SizedBox(height: 10,))
          ],
        ),
      ),
    );
  }
}
