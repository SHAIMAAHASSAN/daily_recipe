import 'package:daily_recipe/pages/forget.password.pages.dart';
import 'package:daily_recipe/pages/register.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth.Provider.dart';
import '../utils/images.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    Provider.of<AuthProviderViewModel>(context, listen: false).initAuth();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: Provider.of<AuthProviderViewModel>(context, listen: false).formKey,
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
                  Image(
                    width: 250, image: AssetImage(ImagesPath.logo),
                  ),

                  const SizedBox(height: 10),
                  const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 15),
                  Consumer<AuthProviderViewModel>(
                      builder: (context, value, child) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            // onChanged: (valid) => value.formKey?.currentState?.validate(),
                            style: const TextStyle(
                                color: Colors.deepOrange, fontSize: 20),
                            controller: value.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
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
                              // onChanged: (valid) => value.formKey?.currentState?.validate(),
                              obscureText: value.obscureText,
                              style: const TextStyle(
                                  color: Colors.deepOrange, fontSize: 20),
                              controller: value.passwordController,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  prefixIcon: const Icon(Icons.lock_outline_sharp),
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
                                          .toggleObscure();

                                    },
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'password is required';
                                }

                              //  if (value.length < 6) {
                              if( !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value)){
                                  return 'Invalid Password must contain capital&small letter&num,';
                                }
                                return null;
                              }),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onTap: (){
                                  NavigationUtils.push(context: context, page: const ForgetPasswordPage());

                                },
                              ),
                            )),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*.60,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.deepOrange),
                              ),
                              onPressed: () async {

                                value.signInUser(context);

                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Positioned(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationUtils.push(
                            context: context, page: const RegisterPage());
                      },
                      child: const Text(
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
