import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snd/MainScreens/homeScreen.dart';
import 'package:snd/MainScreens/homeTabs.dart';
import 'package:snd/global/global.dart';
import 'package:snd/widgets/custom_text_field.dart';
import 'package:snd/widgets/loading_messege.dart';

// import '../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  validateform() async {
    if (emailTextEditingController.text.isNotEmpty &&
        passwordTextEditingController.text.isNotEmpty) {
      loginNow();
    } else {
      //show the error messege
      Fluttertoast.showToast(msg: "Please enter the credentials...");
    }
  }

  //Sign In with google method
  signInwithGoogle() async {
    //begin
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //get auth details
    final GoogleSignInAuthentication? gAuth = await gUser!.authentication;
    //create credential for the users
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken, idToken: gAuth?.idToken);
    //let's goo...
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
    if (userCredential != null) {
      Navigator.push(context, MaterialPageRoute(builder: (c) => HomeTab()));
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingMessege(
            messege: "Please wait! Let's get you logged in",
          );
        });

    User? currentUser;

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            // email: nameTextEditingController.text.trim(),
            email: emailTextEditingController.text.trim(),
            password: passwordTextEditingController.text.trim())
        .then((auth) {
      currentUser = auth.user;
    }).catchError((errorMessege) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error occured 101: \n $errorMessege");
    });
    if (currentUser != null) {
      checkIfUSerRecordExists(currentUser!);
    }
  }

  checkIfUSerRecordExists(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .then((record) async {
      if (record.exists) {
        //check the approved status
        if (record.data()!['status'] == 'approved') {
          await sharedPreferences!.setString("uid", record.data()!['uid']);
          await sharedPreferences!.setString("email", record.data()!['email']);
          await sharedPreferences!.setString("name", record.data()!['name']);
          await sharedPreferences!
              .setString("photourl", record.data()!['photourl']);

          List<String> usercartList = record.data()!['userCart'].cast<String>();
          await sharedPreferences!.setStringList("userCart", usercartList);
          //allow the users to home

          Navigator.push(
              context, MaterialPageRoute(builder: (c) => HomeTab()));
        } else {
          Navigator.pop(context);
          FirebaseAuth.instance.signOut();
          Fluttertoast.showToast(msg: "You are Blocked by the user!");
        }
      } else {
        // FirebaseAuth.instance.signOut();
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "This record is not exists");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image(
            image: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo8cwpEkKX35RhYVhKcKIB9DFHSQNnrabJRP9AzsMKRQ&usqp=CAU&ec=48600112"),
            height: MediaQuery.of(context).size.width * 0.35,
          ),
          const Text(
            "Welcome Back!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Custom_tf(
            textEditingController: emailTextEditingController,
            iconData: Icons.mail,
            hintext: "username009@gmail.com",
            isObsecre: false,
            enabled: true,
          ),
          Custom_tf(
            textEditingController: passwordTextEditingController,
            iconData: Icons.lock,
            hintext: "Enter password",
            isObsecre: true,
            enabled: true,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                shadowColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              onPressed: () {
                validateform();
              },
              child: const Text(
                "Login",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "or Continue with",
            style: TextStyle(fontSize: 15),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Do something when the widget is tapped
                  signInwithGoogle();
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.05,
                  backgroundImage: AssetImage('assets/images/goog.png'),
                ),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  //do for the mac sigin
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.05,
                  backgroundImage: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/2/2235.png"),
                ),
              ),
              // SizedBox(width: 10),
            ],
          )
        ],
      ),
    );
  }
}
