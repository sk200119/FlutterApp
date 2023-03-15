// ignore: implementation_imports

import 'package:flutter/material.dart';
import 'package:snd/MainScreens/homeScreen.dart';


class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Builder(
          builder: (context) => const Scaffold(
                backgroundColor: Color.fromARGB(255, 255, 123, 0),

                bottomNavigationBar: TabBar(
                  labelColor: Colors.black,
                  labelStyle: TextStyle(fontSize: 10),
                  labelPadding: EdgeInsets.all(0),
                  tabs: [
                    Tab(height: 60, icon: Icon(Icons.home), text: "Home"),
                    Tab(
                        height: 60,
                        icon: Icon(Icons.offline_bolt),
                        text: "Boom"),
                    Tab(
                        height: 60,
                        icon: Icon(Icons.subscript_outlined),
                        text: "Subscription"),
                    Tab(
                        height: 60,
                        icon: Icon(Icons.favorite),
                        text: "Favourites")
                  ],
                ),
                body: TabBarView(children: [
                  homeScreen(),
                  Center(child: Text("Boom!!")),
                  Center(child: Text("Subscription")),
                  Center(child: Text("Favourites")),
                  // Center(child: Text("Boom!!"))
                ]),
              )),
    );
  }
}
