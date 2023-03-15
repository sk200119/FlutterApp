import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snd/NextFunctions/Events1.dart';
import 'package:snd/NextFunctions/Offers.dart';
import 'package:snd/NextFunctions/Tourism.dart';
import 'package:snd/authScreens/AuthScreens.dart';
import 'package:snd/authScreens/login_page.dart';
import 'package:snd/authScreens/registration_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:snd/widgets/SearchScreen.dart';

import '../widgets/my_drawer.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    // return Future.error('Location services are disabled.');
    // Fluttertoast.showToast(msg: "Error!!");
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
      // Fluttertoast.showToast(msg: "Error!!");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.0, 1.0],
                  colors: [Color(0xFFFF9800), Color(0xFFF44336)])),
        ),
        title: const Text(
          "ShowNDeal",
          // textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          const SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => AuthScreen()));
              },
              icon: Icon(Icons.person_2_rounded)),
          const SizedBox(width: 10),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notification_add_rounded))
        ],
      ),
      body: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(children: [
            // Drawer(),
            TextField(
              // onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                hintText: "Search Your Location",
                // suffixIcon: const Icon(Icons.locato)
                prefixIcon: IconButton(
                  onPressed: () {
                    // SearchScreen();
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
                suffixIcon: IconButton(
                    onPressed: () async {
                      Position position = await _determinePosition();
                      print(position.latitude);
                    },
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.black,
                    )),
                // prefix: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3DOfIRCm4XNKpt-P2DWrNmXlFHB1Vz6SmwjvKXF3oxw&usqp=CAU&ec=48600112"),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Explore your city!!",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Offers();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) => Offers()));
                        },
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.17,
                          backgroundColor: Colors.deepOrange,
                        ),
                      ),
                      const Text(
                        "Offers",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Events();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) => Events1()));
                        },
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.17,
                          backgroundColor: Colors.deepOrange,
                        ),
                      ),
                      const Text(
                        "Events",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => Tourism()));
                      },
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.17,
                        backgroundColor: Colors.deepOrange,
                        backgroundImage: AssetImage('assets/images/tour.jpg'),
                      ),
                    ),
                    const Text(
                      "Tourism",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    )
                  ]),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.17,
                        backgroundColor: Colors.deepOrange,
                      ),
                      const Text(
                        "Promotions",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
