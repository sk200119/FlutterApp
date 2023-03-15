import 'package:flutter/material.dart';

class Tourism extends StatefulWidget {
  const Tourism({super.key});

  @override
  State<Tourism> createState() => _TourismState();
}

class _TourismState extends State<Tourism> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Tourism wala page"),
    );
  }
}