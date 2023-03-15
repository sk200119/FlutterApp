import 'package:flutter/material.dart';

class LoadingMessege extends StatelessWidget {
  
  final String? messege;

  LoadingMessege({
    this.messege
  });


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 14),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.deepOrangeAccent),
            ),
              
          ),
          Text(
            messege.toString() + " Please wait....",

          )
        ],
      ),
    );
  }
}