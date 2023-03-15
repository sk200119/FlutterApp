import 'package:flutter/material.dart';

class Custom_tf extends StatefulWidget {

  TextEditingController? textEditingController;
  IconData? iconData;
  String? hintext;
  bool? isObsecre = true;
  bool? enabled = true;

  Custom_tf({
    this.textEditingController,
    this.iconData,
    this.hintext,
    this.isObsecre,
    this.enabled, 
  });
  
  @override
  State<Custom_tf> createState() => _Custom_tfState();
}

class _Custom_tfState extends State<Custom_tf> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),

      ),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      child: TextField(
        enabled: widget.enabled,
        controller: widget.textEditingController,
        obscureText: widget.isObsecre!,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            widget.iconData,
            color: Colors.black,
            ),
          focusColor: Theme.of(context).primaryColor,
          hintText: widget.hintext,
        ),
      ),
    );
  }
}