import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snd/MainScreens/homeScreen.dart';
import 'package:snd/authScreens/login_page.dart';
import 'package:snd/global/global.dart';
import 'package:snd/widgets/loading_messege.dart';
import '../widgets/custom_text_field.dart';
import 'package:firebase_storage/firebase_storage.dart' as fstorage;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmpasswordEditingController =
      TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String downloadurlImage ="";

  XFile? imgxfile;
  final ImagePicker imagePicker = ImagePicker();

  getImage() async {
    imgxfile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imgxfile;
    });
  }

  formValidation() async{
    if(imgxfile == null)
    {
        Fluttertoast.showToast(msg: "Image is not selected");
    }
    else
    {
        if(passwordTextEditingController.text == confirmpasswordEditingController.text)
        {
            if(nameTextEditingController.text.isNotEmpty && emailTextEditingController.text.isNotEmpty && passwordTextEditingController.text.isNotEmpty && confirmpasswordEditingController.text.isNotEmpty)
            { 
              showDialog(
                context: context, 
                builder: (c)
                {
                  return LoadingMessege(
                    messege: "Registering your account",
                  );
                }
              );
              // 1. upload the image to the firebase
              String fileName = DateTime.now().millisecondsSinceEpoch.toString();
              fstorage.Reference storageRef = fstorage.FirebaseStorage.instance
              .ref()
              .child("userImages").child(fileName);

              fstorage.UploadTask uploadImageTask = storageRef.putFile(File(imgxfile!.path));

              fstorage.TaskSnapshot taskSnapshot = await uploadImageTask.whenComplete((){}) ;

              await taskSnapshot.ref.getDownloadURL().then((urlImage)
              {
                downloadurlImage = urlImage;

              });

              saveInformation();
            }
            else
            { 
               Navigator.pop(context);
               Fluttertoast.showToast(msg: "Please complete the form! Do not leave any field");
            }
        }
        else{
          Fluttertoast.showToast(msg: "Password and confirm password is not matched");
        }
    }
  }

  saveInformation() async
  {
    User? currentUser;

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
            // email: nameTextEditingController.text.trim(),
            email: emailTextEditingController.text.trim(), 
            password: passwordTextEditingController.text.trim()
        ).then((auth)
        {
          currentUser = auth.user;
      
        }).catchError((errorMessege)
        {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error occured 101: \n $errorMessege");
        });

        if(currentUser != null)
        {
        //for saving this information in database
          saveInfotoFirestoreandLocally(currentUser!); 
          homeScreen();
        }
      
    
  }

  saveInfotoFirestoreandLocally(User currentUser) async
  {
    // saving on firebase
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set(
      {
        "uid": currentUser.uid,
        "email": currentUser.email,
        "name": nameTextEditingController.text.trim(),
        "photourl": downloadurlImage,
        "status": "approved", 
        "userCart": ["InitialValue"],
      }
      // homeScreen();
    );
      
    
    //saving on locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email!);
    await sharedPreferences!.setString("name", nameTextEditingController.text.trim());
    await sharedPreferences!.setString("photourl", downloadurlImage);
    await sharedPreferences!.setStringList("userCart", ["InitialValue"]);
    Navigator.push(context, MaterialPageRoute(builder: (c)=> homeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'reg',
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 12,
                // width: 20,
              ),
          
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.15,
                  backgroundColor: Colors.deepOrange,
                  backgroundImage:
                      imgxfile == null ? null : FileImage(File(imgxfile!.path)),
                  child: imgxfile == null
                      ? Icon(
                          Icons.add_photo_alternate,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.15,
                        )
                      : null,
                ),
              ),
              const SizedBox(
                height: 12,
                // width: 20,
              ),
          
              //input_TextField
              Form(
                key: formkey,
                child: Column(
                  children: [
                    Custom_tf(
                      textEditingController: nameTextEditingController,
                      iconData: Icons.person,
                      // color: Colors.accents,
                      hintext: "Name",
                      isObsecre: false,
                      enabled: true,
                      
                    ),
                    //2 mail
                    Custom_tf(
                      textEditingController: emailTextEditingController,
                      iconData: Icons.mail,
                      hintext: "Gmail",
                      isObsecre: false,
                      enabled: true,
                    ),
                    Custom_tf(
                      textEditingController: passwordTextEditingController,
                      iconData: Icons.lock,
                      hintext: "Password",
                      isObsecre: true,
                      enabled: true,
                    ),
                    Custom_tf(
                      textEditingController: confirmpasswordEditingController,
                      iconData: Icons.lock,
                      hintext: "Confirm Password",
                      isObsecre: true,
                      enabled: true,
                    ),
          
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
          
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shadowColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  onPressed: () 
                  {
                    formValidation();
                    // homeScreen();
                  },
                  child: const Text(
                    "Signup",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
