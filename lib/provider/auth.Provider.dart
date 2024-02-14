import 'package:daily_recipe/pages/home.page.dart';
import 'package:daily_recipe/pages/login.page.dart';
import 'package:daily_recipe/pages/register.page.dart';
import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:daily_recipe/utils/toast.message.utils.dart';
import 'package:daily_recipe/utils/toast.status.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';

class AuthProviderViewModel extends ChangeNotifier {
  bool obscureText = true;
  GlobalKey<FormState>? formKey;
  GlobalKey<FormState>? resetPasswordFormKey;
  GlobalKey<FormState>? updateProfileFormKey;
  TextEditingController? emailController;
  TextEditingController? usernameController;
  TextEditingController? passwordController;
  TextEditingController? updateUsernameController;
  TextEditingController? phoneController;
  TextEditingController? otpController;
  GlobalKey<FormState>? otpFormKey;
  String? downloadURL;
  String? photo;
  String verifyId = "";

  void initAuth() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    updateUsernameController = TextEditingController();
    otpController = TextEditingController();
    resetPasswordFormKey = GlobalKey<FormState>();
  }

  void initUpdate() {
    otpController = TextEditingController();
    otpFormKey = GlobalKey();
    updateProfileFormKey = GlobalKey<FormState>();
    usernameController = TextEditingController();
    phoneController = TextEditingController();
  }

  void providerDispose() {
    otpController = null;
    otpFormKey = null;
    updateProfileFormKey = null;
    usernameController = null;
    updateUsernameController = null;
    phoneController = null;
    passwordController = null;
    emailController = null;
    passwordController = null;
    formKey = null;
    usernameController = null;
    obscureText = true;
  }

  void toggleObscure() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void openRegisterPage(BuildContext context) {
    providerDispose();
    NavigationUtils.pushReplacement(context: context, page: const RegisterPage());
  }

  void openLoginPage(BuildContext context) {
    providerDispose();
    NavigationUtils.pushReplacement(context: context, page: const LoginPage());
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
      if (context.mounted) {
        if (e.code == 'user-not-found') {
          ToastMessageUtils.showToastMessage(
              context, ToastStatus.failed, 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
              'Wrong password provided for that user.');
        } else if (e.code == 'invalid-email') {
          ToastMessageUtils.showToastMessage(
              context, ToastStatus.failed, 'Invalid email address.');
        }
        if (e.code == 'network-errors') {
          ToastMessageUtils.showToastMessage(
              context, ToastStatus.failed, 'Network errors,Try again.');
        }
        if (e.code == 'email-already-in-use') {
          ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
              'Email already exists by another user.');
        } else {
          ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
              'Something went wrong with Firebase Auth.$e');
        }
      }
    }
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
          await userCredential.user!.updateDisplayName(
              FirebaseAuth.instance.currentUser!.displayName!);
          photo = FirebaseAuth.instance.currentUser!.photoURL;

          OverlayLoadingProgress.stop();
          providerDispose();
          if (context.mounted) {
            ToastMessageUtils.showToastMessage(context, ToastStatus.success,
                'Successful login,Welcome ${"${FirebaseAuth.instance.currentUser!.displayName}"}');

            NavigationUtils.pushReplacement(context: context, page: const HomePage());
            ToastMessageUtils.showToastMessage(
                context, ToastStatus.success, "Enjoy with our recipes.");
          }
        }
        OverlayLoadingProgress.stop();
      }
    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();
      if (context.mounted) {
        if (e.code == 'user-not-found') {
          ToastMessageUtils.showToastMessage(
              context, ToastStatus.failed, 'No user found for that email.');
        } else if (e.code == 'wrong-password') {
          ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
              'Wrong password provided for that user.');
        } else if (e.code == 'invalid-email') {
          ToastMessageUtils.showToastMessage(
              context, ToastStatus.failed, 'Invalid email address.');
        } else if (e.code == 'network-errors') {
          ToastMessageUtils.showToastMessage(
              context, ToastStatus.failed, 'Network errors,Try again.');
        } else if (e.code == 'email-already-in-use') {
          ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
              'Email already exists by another user.');
        } else if (e.code == 'invalid-credential') {
          ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
              ' The supplied auth credential is incorrect.');
        } else {
          ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
              'Something went wrong with Firebase Auth.$e');
        }
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    OverlayLoadingProgress.start();
    await Future.delayed(const Duration(seconds: 1));
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      NavigationUtils.pushAndRemoveUntil(context: context, page: const StartPage());
    }
    OverlayLoadingProgress.stop();
  }

  Future<void> forgetPassword(BuildContext context, String email) async {
    OverlayLoadingProgress.start();
    try {
      if (resetPasswordFormKey?.currentState?.validate() ?? false) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        if (context.mounted) {
          ToastMessageUtils.showToastMessage(context, ToastStatus.success,
              'Check your Email to reset password .');
          NavigationUtils.push(context: context, page: const LoginPage());
        }
      }

      OverlayLoadingProgress.stop();
    } on FirebaseAuthException catch (e) {
      OverlayLoadingProgress.stop();
      if (context.mounted) {
        if (e.code == 'user-not-found') {
          ToastMessageUtils.showToastMessage(
              context, ToastStatus.failed, 'user-not-found .');
        } else {
          ToastMessageUtils.showToastMessage(context, ToastStatus.failed, '$e');
        }
      }
    }
  }

  void updateName(BuildContext context) {
    if (updateProfileFormKey?.currentState?.validate() ?? false) {
      FirebaseAuth.instance.currentUser!
          .updateDisplayName(usernameController!.text);
      ToastMessageUtils.showToastMessage(
          context, ToastStatus.success, "Successful Update Profile.");
    }
    notifyListeners();
  }

  void sentOtp(
      {required String phone,
      required Function errorStep,
      required Function nextStep}) async {
    if (updateProfileFormKey?.currentState?.validate() ?? false) {
      await FirebaseAuth.instance
          .verifyPhoneNumber(
        timeout: const Duration(seconds: 30),
        phoneNumber: "+2$phone",
        verificationCompleted: (phoneAuthCredential) async {
          return;
        },
        verificationFailed: (error) async {
          return;
        },
        codeSent: (verificationId, forceResendingToken) async {
          verifyId = verificationId;
          nextStep();
        },
        codeAutoRetrievalTimeout: (verificationId) async {
          return;
        },
      )
          .onError((error, stackTrace) {
        errorStep();
      });
    }
  }

  Future<void> updateImageProfile() async {
    OverlayLoadingProgress.start();
    var imageResult = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);

    var reference = FirebaseStorage.instance
        .ref('imageProfile/${imageResult?.files.first.name}');

    if (imageResult?.files.first.bytes != null) {
      var uploadResult = await reference.putData(
          imageResult!.files.first.bytes!,
          SettableMetadata(contentType: 'image/png'));

      if (uploadResult.state == TaskState.success) {
        downloadURL = await reference.getDownloadURL();

        FirebaseAuth.instance.currentUser!.updatePhotoURL(downloadURL);

        photo = downloadURL;
        notifyListeners();

        OverlayLoadingProgress.stop();
      }
    }

    OverlayLoadingProgress.stop();
  }

  void updatePhoneNumber(BuildContext context, String otp) async {
    if (updateProfileFormKey?.currentState!.validate() ?? false) {
      try {
        var credential = PhoneAuthProvider.credential(
          verificationId: verifyId,
          smsCode: otp,
        );

        OverlayLoadingProgress.start();
        await FirebaseAuth.instance.currentUser!.updatePhoneNumber(credential);
        OverlayLoadingProgress.stop();

        if (context.mounted) {
          ToastMessageUtils.showToastMessage(context, ToastStatus.success,
              'Phone number updated successfully');
        }
      } on FirebaseAuthException catch (e) {
        OverlayLoadingProgress.stop();

        if (context.mounted) {
          if (e.code == 'invalid-verification-code') {
            ToastMessageUtils.showToastMessage(
                context, ToastStatus.failed, 'Invalid verification code');
          } else {
            ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
                e.message ?? 'Failed to update phone number');
          }
        }
      } catch (e) {
        OverlayLoadingProgress.stop();

        if (context.mounted) {
          ToastMessageUtils.showToastMessage(
              context, ToastStatus.failed, 'Failed to update phone number');
        }
      }
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    providerDispose();
    // TODO: implement dispose
    super.dispose();
  }
}
