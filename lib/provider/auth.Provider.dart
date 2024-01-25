import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/pages/home.page.dart';
import 'package:daily_recipe/pages/login.page.dart';
import 'package:daily_recipe/pages/register.page.dart';
import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:daily_recipe/utils/toast.message.utils.dart';
import 'package:daily_recipe/utils/toast.status.dart';
import 'package:daily_recipe/widgets/page.view.dart';
import 'package:daily_recipe/widgets/toast.message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_kit/overlay_kit.dart';

class AuthProviderViewModel extends ChangeNotifier {
  bool obscureText = true;
  GlobalKey<FormState>? formKey;

  TextEditingController? emailController;
  TextEditingController? usernameController;
  TextEditingController? passwordController;
  String username ="";

  late AnimationController animationController;

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
    obscureText = true;
  }

  void toggleObsecure() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void openRegisterPage(BuildContext context) {
    providerDispose();
    NavigationUtils.pushReplacement(context: context, page: RegisterPage());
  }

  void openLoginPage(BuildContext context) {
    providerDispose();
    NavigationUtils.pushReplacement(context: context, page: LoginPage());
  }

  Future<void> registerUser(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        OverlayLoadingProgress.start();
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController!.text,
                password: passwordController!.text);

        if (userCredential.user != null) {
          await userCredential.user!
              .updateDisplayName(usernameController!.text);
          OverlayLoadingProgress.stop();
          providerDispose();

          if (context.mounted) {
            openLoginPage(context);
          }
        }
        OverlayLoadingProgress.stop();
      }
    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();
      if(context.mounted){
      if (e.code == 'user-not-found') {

        ToastMessageUtils.showToastMessage(
            context, ToastStatus.failed, 'No user found for that email.');
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
            'Wrong password provided for that user.');
        //  print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        ToastMessageUtils.showToastMessage(
            context, ToastStatus.failed, 'Invalid email address.');

        // print('Invalid email address.');
      }
      if (e.code == 'network-errors') {
        ToastMessageUtils.showToastMessage(
            context, ToastStatus.failed, 'Network errors,Try again.');

        // print('Network errors.');
      }
      if (e.code == 'email-already-in-use') {
        ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
            'Email already exists by another user.');

        // print('Email already exists by another user.');
      } else {
        ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
            'Something went wrong with Firebase Auth.$e');

        //print('Something went wrong with Firebase Auth.$e');
      }
    }}
  }

  Future<void> signInUser(BuildContext context) async {
    try {
      if (formKey?.currentState?.validate() ?? false) {
        OverlayLoadingProgress.start();
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController!.text,
          password: passwordController!.text,
        );

        if (userCredential.user != null) {
          await userCredential.user!
              .updateDisplayName(FirebaseAuth.instance.currentUser!.displayName!);
        /* username =
              FirebaseAuth.instance.currentUser!.displayName!;*/
          OverlayLoadingProgress.stop();
          providerDispose();

          if (context.mounted) {
             ToastMessageWidget(toastStatus: ToastStatus.success,
                message:'Successful login,Welcome ${"${FirebaseAuth.instance.currentUser!.displayName}"}');
           // ToastMessageUtils.toastMessage(context, ToastStatus.success,
             //  'Successful login,Welcome ${"${FirebaseAuth.instance.currentUser!.displayName}"}');

            NavigationUtils.pushReplacement(
                context: context, page: HomePage());
          }
        }
        OverlayLoadingProgress.stop();
      }
    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();
      if (e.code == 'user-not-found') {
        const ToastMessageWidget(toastStatus: ToastStatus.failed, message: 'No user found for that email.');
      //  ToastMessageUtils.toastMessage(
          // context,ToastStatus.failed, 'No user found for that email.');
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        if(context.mounted){
        ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
            'Wrong password provided for that user.');}
        //  print('Wrong password provided for that user.');
      } else if (e.code == 'invalid-email') {
        if(context.mounted){
        ToastMessageUtils.showToastMessage(
            context, ToastStatus.failed, 'Invalid email address.');}

        // print('Invalid email address.');
      }
      if (e.code == 'network-errors') {
        if(context.mounted){
        ToastMessageUtils.showToastMessage(
            context, ToastStatus.failed, 'Network errors,Try again.');}

        // print('Network errors.');
      }
      if (e.code == 'email-already-in-use') {
        if(context.mounted){
        ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
            'Email already exists by another user.');}

        // print('Email already exists by another user.');
      } else {
        if(context.mounted){
        ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
            'Something went wrong with Firebase Auth.$e');}

        //print('Something went wrong with Firebase Auth.$e');
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    OverlayLoadingProgress.start();
    await Future.delayed(const Duration(seconds: 1));
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      NavigationUtils.pushAndRemoveUntil(context: context, page: StartPage());
    }
    OverlayLoadingProgress.stop();
  }

  @override
  void dispose() {
    providerDispose();
    // TODO: implement dispose
    super.dispose();
  }
}
