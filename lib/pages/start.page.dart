import 'package:daily_recipe/pages/login.page.dart';
import 'package:daily_recipe/pages/register.page.dart';
import 'package:daily_recipe/utils/images.dart';
import 'package:flutter/material.dart';
import '../utils/navigation.utils.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImagesPath.background,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 10.0, top: 40, right: 40, left: 40),
              child: Image(
                image: AssetImage(ImagesPath.logo),
              ),
            ),
            const Text(
              "Cooking Done The Easy Way",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width*.60,
              child: ElevatedButton(
                onPressed: () {
                  NavigationUtils.push(
                      context: context, page: const RegisterPage());
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepOrange),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.restaurant_menu_sharp),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Register",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  NavigationUtils.push(
                      context: context, page: const LoginPage());
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Sign In",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
