import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameapp/class/user.dart';
import 'package:gameapp/widgets/txtbox.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterSubPage extends StatefulWidget {
  RegisterSubPage(
      {this.onSubmit,
      this.controller,
      this.fields,
      this.children = const <TxtBox>[],
      this.isLastPage = false});
  final PageController controller;
  final Map<String, String> fields;
  final List<TxtBox> children;
  final bool isLastPage;
  final Future<Map<String, dynamic>> Function() onSubmit;
  @override
  _RegisterSubPageState createState() => _RegisterSubPageState();
}

class _RegisterSubPageState extends State<RegisterSubPage> {
  bool isLoading = false;
  void _nextPage() async {
    if (!widget.isLastPage) {
      widget.controller
          .nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
      print(widget.fields);
    } else {
      setState(() {
        isLoading = true;
      });
      await widget
      .onSubmit()
      .then((value)async{
        await authenticateUser(widget.fields).then((value){
          Navigator.pushNamed(context,"/dashboard");
          setState((){
            isLoading=false;
          });
        });
        
      })
      .catchError((error){
        setState((){
          isLoading=false;
        });
        Map<String,dynamic> x = error["ModelState"];
        var e=StringBuffer();
        x.forEach((key, value) {
          e.writeln(value);
        });
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content:Text(e.toString())
          )
        );
      });
      
           
    }
  }

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
                    widget.controller.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  },
                ),
              ]),
              Column(
                children: widget.children,
              ),
              Padding(padding: EdgeInsets.all(10)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: isLoading ? CircularProgressIndicator() : Center(),
                ),
                RaisedButton(
                  color: Colors.black,
                  onPressed: _nextPage,
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
            ]),
      ),
    );
  }
}
