import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snd/MainScreens/SplashScreen.dart';
import 'package:snd/MainScreens/homeTabs.dart';
import 'package:snd/authScreens/authScreens.dart';
import 'package:snd/global/global.dart';
import 'MainScreens/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future <void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  
  sharedPreferences = await SharedPreferences.getInstance();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  runApp ( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnD User App',
      theme: ThemeData(
       
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(),
    );
  }
}

