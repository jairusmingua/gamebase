import 'package:flutter/material.dart';
import 'package:gameapp/widgets/txtbox.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PageController controller =
        new PageController(initialPage: 0, keepPage: false);
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              'images/gamebg.webp',
              fit: BoxFit.cover,
            )),
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black87,
        ),
        Container(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
            alignment: Alignment.topLeft,
            height: double.infinity,
            width: double.infinity,
            child: PageView(
              // physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                RegisterFirstPage(controller: controller),
                RegisterSecondPage(
                  controller: controller,
                ),
                Text("World", style: TextStyle(color: Colors.white)),
              ],
            )),
      ]),
    );
  }
}

class RegisterFirstPage extends StatelessWidget {
  RegisterFirstPage({this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start, children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  iconSize: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                // Text("Register")
              ]),
              Column(
                children: [
                  TxtBox(
                    placeholder: "First Name",
                  ),
                  TxtBox(
                    placeholder: "Second Name",
                  ),
                  TxtBox(
                    placeholder: "Email",
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              RaisedButton(
                color: Colors.black,
                onPressed: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Next",
                    style: GoogleFonts.montserrat(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}

class RegisterSecondPage extends StatelessWidget {
  RegisterSecondPage({this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  iconSize: 40,
                  onPressed: () {
                    controller.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  },
                ),
              ]),
              // Column(
              //   children: [

              //   ],
              // ),
              Padding(padding: EdgeInsets.all(10)),
              RaisedButton(
                color: Colors.black,
                onPressed: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Next",
                    style: GoogleFonts.montserrat(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
