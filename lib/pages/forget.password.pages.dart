import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth.Provider.dart';
import '../utils/images.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: Provider.of<AuthProviderViewModel>(context, listen: false)
                .resetPasswordFormKey,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagesPath.backgroundEffect),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      width: 250, image: AssetImage(ImagesPath.logo),
                      //   alignment: Alignment.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Reset Password',
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
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width*.75,
                            //width: 250,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.deepOrange),
                                ),
                                onPressed: () async {
                                  value.forgetPassword(
                                      context, value.emailController!.text);
                                },
                                child: const Text(
                                  'Reset Password',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    })
                  ]),
            )));
  }
}
