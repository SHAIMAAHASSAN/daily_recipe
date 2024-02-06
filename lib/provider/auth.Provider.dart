import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipe/pages/home.page.dart';
import 'package:daily_recipe/pages/login.page.dart';
import 'package:daily_recipe/pages/register.page.dart';
import 'package:daily_recipe/pages/side.menu.page.dart';
import 'package:daily_recipe/pages/start.page.dart';
import 'package:daily_recipe/utils/navigation.utils.dart';
import 'package:daily_recipe/utils/toast.message.utils.dart';
import 'package:daily_recipe/utils/toast.status.dart';
import 'package:daily_recipe/widgets/page.view.dart';
import 'package:daily_recipe/widgets/toast.message.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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


  String username ="";

  final _formKey = GlobalKey<FormState>();
 /* User? user;
 TextEditingController displayNameController = TextEditingController();
  TextEditingController emailControllerUpdate = TextEditingController();*/
 // File? imageFile;
   String? downloadURL;
  String? photo ;

 // late AnimationController animationController;

  void initProvider() {
    formKey = GlobalKey<FormState>();

  /*  user = FirebaseAuth.instance.currentUser;
    displayNameController.text = user?.displayName ?? "";
    emailControllerUpdate!.text = user?.email ?? "";*/
    emailController = TextEditingController();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
     updateUsernameController = TextEditingController();
   phoneController=TextEditingController();
    resetPasswordFormKey = GlobalKey<FormState>();
  }
  void initUpdate(){
    updateProfileFormKey=GlobalKey<FormState>();
    usernameController = TextEditingController();

  }

  void providerDispose() {
    updateProfileFormKey=null;
    updateUsernameController=null;
    phoneController=null;
    passwordController=null;
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
              .updateDisplayName(
              FirebaseAuth.instance.currentUser!.displayName!);
          photo = FirebaseAuth.instance.currentUser!.photoURL;
          /* username =
              FirebaseAuth.instance.currentUser!.displayName!;*/
          OverlayLoadingProgress.stop();
          providerDispose();
          if (context.mounted) {
            ToastMessageUtils.showToastMessage(context, ToastStatus.success,
                'Successful login,Welcome ${"${FirebaseAuth.instance
                    .currentUser!.displayName}"}');

            NavigationUtils.pushReplacement(
                context: context, page: HomePage());
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
          // const ToastMessageWidget(toastStatus: ToastStatus.failed, message: 'No user found for that email.');
          ToastMessageUtils.showToastMessage(
              context, ToastStatus.failed, 'No user found for that email.');
          // print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
              'Wrong password provided for that user.');
        }
        //  print('Wrong password provided for that user.');
        else if (e.code == 'invalid-email') {
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

          if (e.code == 'invalid-credential') {
            ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
                ' The supplied auth credential is incorrect.');
            // print('The supplied auth credential is incorrect.');
          } else {
            ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
                'Something went wrong with Firebase Auth.$e');

            print('Something went wrong with Firebase Auth.$e');
          }
        }
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

  Future<void> forgetPassword(BuildContext context,String email) async {
    OverlayLoadingProgress.start();
      try {
        if (resetPasswordFormKey?.currentState?.validate() ?? false) {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
          if(context.mounted){
          ToastMessageUtils.showToastMessage(context, ToastStatus.success,
              'Check your Email to reset password .');
          NavigationUtils.push(context: context, page: LoginPage());}
        }
        // Display a success message to the user
        OverlayLoadingProgress.stop();
      }



      on FirebaseAuthException catch (e) {
        OverlayLoadingProgress.stop();
        if (context.mounted) {
          // Handle errors, such as invalid email or network errors
          if (e.code == 'user-not-found') {
            ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
                'user-not-found .');
            // Display a message that the user does not exist
          } else {
            ToastMessageUtils.showToastMessage(context, ToastStatus.failed,
                '$e');
            // Display a generic error message
          }
        }
      }
  }

  void updateName(BuildContext context) {
    if (updateProfileFormKey?.currentState?.validate() ?? false) {

        FirebaseAuth.instance.currentUser!
            .updateDisplayName(
           usernameController!.text);
    ToastMessageUtils.showToastMessage(context, ToastStatus.success, "Successful Update Profile.");

    }
    notifyListeners();
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
        downloadURL=await reference.getDownloadURL();
        print(
            '?????image upload successfully $downloadURL/*{await reference.getDownloadURL()}*/');
       FirebaseAuth.instance.currentUser!.updatePhotoURL(downloadURL);
       print("-----------------photo after update provider ==${FirebaseAuth.instance.currentUser!.photoURL}--------------");
       photo = downloadURL;
        notifyListeners();

        OverlayLoadingProgress.stop();

      }

    }

    OverlayLoadingProgress.stop();
   // notifyListeners();


   /* if (_formKey.currentState!.validate()) {
      try {
        UserUpdateInfo updateInfo = UserUpdateInfo();
        updateInfo.displayName = displayNameController.text;
        if (emailControllerUpdate.text != user!.email) {
          await user!.updateEmail(emailControllerUpdate.text);
        }
        if (imageFile != null) {
          // Upload profile picture to Firebase Storage
          FirebaseStorage storage = FirebaseStorage.instance;
          Reference ref = storage.ref().child("profile_images/${user!.uid}.jpg");
          UploadTask uploadTask = ref.putFile(imageFile!);
          await uploadTask;
          downloadURL = await ref.getDownloadURL();
          updateInfo.photoURL = downloadURL;
        }
        await user!.updateProfile(updateInfo);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Profile updated successfully!"),
        ));
      } catch (e) {
        // Handle errors
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error updating profile: $e"),
        ));
      }*/
    }

  Future<void> updatePhoneNumber() async {
    try {
      // Get verification code from the user
      String verificationCode = '...';
      String verificationId = '';// Replace with actual code

      // Create PhoneAuthCredential
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: verificationCode,
      );

      // Link phone authentication
      await FirebaseAuth.instance.currentUser?.linkWithCredential(credential);

      // Handle successful linking
      // ...
    } on FirebaseAuthException catch (e) {
      // Handle linking error
      // ...
    }
  }

  @override
  void dispose() {
    providerDispose();
    // TODO: implement dispose
    super.dispose();
  }
}
