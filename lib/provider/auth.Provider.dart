import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/pages/home.page.dart';
import 'package:daily_recipe/pages/login.page.dart';
import 'package:daily_recipe/pages/register.page.dart';
import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:daily_recipe/widgets/page.view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProviderViewModel extends ChangeNotifier {
  bool obscureText = false;
  GlobalKey<FormState>? formKey;

  TextEditingController? emailController;
  TextEditingController? usernameController;
  TextEditingController? passwordController;

  void initProvider() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  void providerDispose() {
    emailController = null;
    passwordController = null;
    formKey = null;
    usernameController = null;
    obscureText = false;
  }

  void toggleObsecure() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void openRegisterPage(BuildContext context) {
    providerDispose();
    NavigationUtils.pushReplacement(context: context, page: RegisterPage());
  }

  Future<void> openLoginPage(BuildContext context) async {
    try {

        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController!.text,
          password: passwordController!.text,
        );

          FirebaseAuth.instance.currentUser!
              .updateDisplayName(usernameController!.text);

          providerDispose();
          NavigationUtils.push(context: context, page: LoginPage());
      //  }
     // }
    } catch (e) {
      print("================error register ==>$e");
      Fluttertoast.showToast(
        msg: "Sorry you can't create an account ${e}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.white,
      );
    }
    // Update username in Firebase database
    /*  await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid)
          .set({'username': usernameController});
*/
    /*  // Retrieve the saved username immediately
      DocumentSnapshot userDocument = await FirebaseFirestore.instance
          .collection('users').doc(userCredential.user!.uid).get();
      String savedUsername = userDocument.get('username');

      // Update username in Firebase database (if needed)
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // Handle weak password error
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: 'error in login ${e}"}',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.white,

        );

       print("email-already-in-use");
      }*/
    //}
  }

  Future<void> signInUser(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController!.text,
        password: passwordController!.text,
      );
      Fluttertoast.showToast(
        msg:
            'Successful login,Welcome ${"${FirebaseAuth.instance.currentUser!.displayName}"}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.white,
      );
      providerDispose();

      NavigationUtils.pushReplacement(context: context, page: PageViewPages());
    } catch (e) {
      print("================error==>$e");
    }
    /*on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Handle user not found error
      } else if (e.code == 'wrong-password') {
        // Handle wrong password error
      }
    }*/
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    //providerDispose();
    NavigationUtils.push(context: context, page: StartPage());
    notifyListeners();
  }

  @override
  void dispose() {
    providerDispose();
    // TODO: implement dispose
    super.dispose();
  }
}
