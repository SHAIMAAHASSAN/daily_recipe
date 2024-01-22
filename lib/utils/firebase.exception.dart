abstract class FirebaseExcptionHandler{

  void onFirebaseAuthException ( e) {
  if (e.code == 'user-not-found') {
  print('  No user found for that email.');
  } else

  if (e.code == 'wrong-password') {
  print('Wrong password provided for that user.');
  } else

  if (e.code == 'invalid-email') {
  print('Invalid email address.');
  }
  if (e.code == 'network-errors') {
  print('Network errors.');
  }
  if (e.code == 'email-already-in-use') {
  print('Email already exists by another user.');
  }
  else {
  print('Something went wrong with Firebase Auth.');
  }

  }


  }




