import 'package:flutter/material.dart';

class TxtBox extends StatelessWidget {
  TxtBox({this.placeholder, this.isPassword = false,this.onChanged});
  final String placeholder;
  final bool isPassword;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
 
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: onChanged,
            style: TextStyle(color: Colors.white),
            obscureText: isPassword == false ? false : true,
            decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
                hintText: placeholder),
          ),
        ),
      ),
    );
  }
}
