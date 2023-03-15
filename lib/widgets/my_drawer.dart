import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snd/authScreens/AuthScreens.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white12,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 26, bottom: 12),
            child: Column(
              children: const [
                //userProfie
                SizedBox(
                  height: 70,
                  width: 70,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/6522/6522516.png'
                        ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                //userName
                Text(
                  "Username",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 1),
              child: Column(
                children: [
                  const Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  ListTile(
                    leading: const Icon(Icons.home, color: Colors.grey),
                    title: const Text(
                      "Home",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    onTap: () {},
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.kayaking_outlined, color: Colors.grey),
                    title: const Text(
                      "MyCart",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    onTap: () {},
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.favorite_sharp, color: Colors.grey),
                    title: const Text(
                      "Favourites",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    onTap: () {},
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.search, color: Colors.grey),
                    title: const Text(
                      "Search",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    onTap: () {},
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.logout_outlined, color: Colors.grey),
                    title: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    onTap: () 
                    {
                      FirebaseAuth.instance.signOut();
                      // Navigator.push(context, MaterialPageRoute(builder: (c)=> AuthScreen()));
                    },
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.search, color: Colors.grey),
                    title: const Text(
                      "Register",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> AuthScreen()));
                    },
                  ),
                  
                ],
              ))
        ],
      ),
    );
  }
}
