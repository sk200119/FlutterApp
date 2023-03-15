import 'package:flutter/material.dart';
import 'package:snd/authScreens/login_page.dart';
import 'package:snd/authScreens/registration_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.0, 1.0],
                  colors: [Color(0xFFFF9800), Color(0xFFF44336)])),
          ),
          title: const Text("ShowNDeal",
        // textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold
          
        ),),
        bottom: const TabBar(
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: "login",
              icon: Icon(Icons.login_outlined),
              ),
            Tab(
              text: "Registration",
              icon: Icon(Icons.app_registration),
            )
            
          ],
        ),
        ),
        body: 
        TabBarView(
          children: [
            LoginPage(),
            RegistrationPage(),
            
          ],
        ),
      ),

      
    );
  }
}