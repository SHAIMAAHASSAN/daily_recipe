import 'package:daily_recipe/pages/login.page.dart';
import 'package:daily_recipe/provider/auth.Provider.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
        body: Consumer<AuthProviderViewModel>(builder: (context, value, child) {
      return Form(
        key: value.formKey,
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
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            //onChanged: (valid) => value.formKey?.currentState?.validate(),
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
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            // onChanged: (valid) => value.formKey?.currentState?.validate(),
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
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                              // onChanged: (valid) => value.formKey?.currentState?.validate(),
                              obscureText: value.obscureText,
                              style: const TextStyle(
                                  color: Colors.deepOrange, fontSize: 18),
                              controller: value.passwordController,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  prefixIcon:
                                      const Icon(Icons.lock_outline_sharp),
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
                              validator: (valid) {
                                if (valid == null || valid.isEmpty) {
                                  return 'password is required';
                                }
                               // !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                if( !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(valid))

                                {
                                  return 'Invalid Password must contain capital&small letter&num,';
                                }
                                return null;
                              }),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*.60,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.deepOrange),
                              ),
                              onPressed: () {

                                value.registerUser(context);

                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
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

                  children: [
                    const Text(
                      "Already registered?",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        NavigationUtils.push(
                            context: context, page: const LoginPage());

                      },
                      child: const Text(
                        "Sign in",
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            )),
          ],
        ),
      );
    }));
  }
}
