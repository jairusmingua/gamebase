import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  SearchBar({this.onChange});
  final Function(String) onChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:30),
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
        margin: EdgeInsets.all(10),
        // height: 45,
        width: double.infinity,
        decoration:
            BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4), 
        //         boxShadow: [
        //             BoxShadow(
        //             color: Colors.grey.withOpacity(0.5),
        //             spreadRadius: 3,
        //             blurRadius: 7,
        //             offset: Offset(0, 2), // changes position of shadow
        //           ),
        // ]
        ),
        child: Container(
          margin: const EdgeInsets.only(top:8.0),
          child: TextField(
              onChanged: onChange,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
            border: InputBorder.none, hintText: 'Enter a search term'),
            ),
        ),
      ),
    );
  }
}
