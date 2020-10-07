import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      height: 50,
      width: double.infinity,
      decoration:
          BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4), 
              boxShadow: [
                  BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
      ]),
      child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none, hintText: 'Enter a search term'),
      ),
    );
  }
}
