import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices
{

  signInwithGoogle()
  async {
    //begin
    final GoogleSignInAccount? gUser= await GoogleSignIn().signIn();

    //get auth details
    final GoogleSignInAuthentication? gAuth= await gUser!.authentication;
    //create credential for the users
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth?.accessToken,
      idToken: gAuth?.idToken
    );
    //let's goo...
    UserCredential userCredential= await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
  }

}