import 'package:flutter/material.dart';
import 'package:gameapp/widgets/txtbox.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/registersubpage.dart';
import '../class/user.dart';

class RegisterMain extends StatefulWidget {
  @override
  _RegisterMainState createState() => _RegisterMainState();
}

class _RegisterMainState extends State<RegisterMain> {
   Map<String,String> _fields = {
    "firstname":"" ,
    "lastname":"",
    "email":"",
    "username":"",
    "password":""
  };
  void _changeField(String key,String val){
    setState((){
      _fields[key] = val;
    });
  }
  Future <Map<String,dynamic>>_registerUser()async{
    
    final response = await registerUser(_fields);
    if(response["registered"]==true){
      
      return response;
    }else{
      throw response;

    }
  }
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
                
                RegisterSubPage(
                  controller: controller,
                 
                  fields: _fields,
                  children:[
                    TxtBox(
                      placeholder: "First Name",
                      onChanged: (val){_changeField("firstname", val);}
                    ),
                    TxtBox(
                      placeholder: "Last Name",
                      onChanged: (val){_changeField("lastname", val);}
                    ),
                    TxtBox(
                      placeholder: "Email",
                      onChanged: (val){_changeField("email", val);}
                    ),
                  ]
                ),
                RegisterSubPage(
                  controller: controller,
                  fields: _fields,
                  isLastPage: true,
                  onSubmit: _registerUser,
                  children:[
                    TxtBox(
                      placeholder: "Username",
                      onChanged: (val){_changeField("username", val);}
                    ),
                    TxtBox(
                      placeholder: "Password",
                      isPassword: true,
                      onChanged: (val){_changeField("password", val);}
                    )
                  ]
                )
              ],
            )),
      ]),
    );
  }
}

