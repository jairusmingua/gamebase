import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gameapp/class/user.dart';
import 'package:gameapp/services/storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _storage = FlutterSecureStorage();

  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  void _logout() async {
    await storeStorage("isLoggedIn", "false");
    await removeStorage("token");
    Navigator.pop(_scaffold.currentContext);
  }

  void _showLogout() {
    showDialog(
        context: _scaffold.currentContext,
        builder: (_) => AlertDialog(
              title: Text("Logout"),
              content: Text("Do you really want to logout?",
                  style: TextStyle(color: Colors.black)),
              actions: [
                FlatButton(onPressed: _logout, child: Text("Yes")),
                FlatButton(
                    onPressed: () => Navigator.pop(_scaffold.currentContext),
                    child: Text("No")),
              ],
            ));
  }

  void _showAbout() {
    showAboutDialog(
        context: _scaffold.currentContext,
        applicationName: "🎮 GameBase",
        applicationVersion: "0.0.0-alpha.1",
        applicationLegalese:
            "A project in fulfillment for Dotnet 4\nSubmitted by:\n\nJairus Mingua\nJerome Desiderio\nJaps Tribiana");
  }

  void _showChangePassword() {
    print("show");
    showDialog(
        context: _scaffold.currentContext,
        builder: (_) => ChangePasswordDialog()).then((value) {
      if (value == true) {
        showDialog(
            context: _scaffold.currentContext,
            builder: (_) => AlertDialog(
                  title: Text("Success"),
                  content: Text("Password successfully changed!",
                      style: TextStyle(color: Colors.black)),
                  actions: [
                    FlatButton(onPressed: _logout, child: Text("Ok")),
                  ],
                ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _style = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
        key: _scaffold,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 90,
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: SafeArea(child: SettingHeader()),
        ),
        body: Container(
          child: ListView(children: [
            ListTile(
              leading: Icon(
                Icons.vpn_key,
                color: Colors.white,
              ),
              title: Text(
                "Change Password",
                style: _style,
              ),
              onTap: _showChangePassword,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: Text(
                "Logout",
                style: _style,
              ),
              onTap: _showLogout,
            ),
            ListTile(
              leading: Icon(
                Icons.group,
                color: Colors.white,
              ),
              title: Text(
                "About Us",
                style: _style,
              ),
              onTap: _showAbout,
            ),
          ]),
        ));
  }
}

class SettingHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Settings",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).textTheme.headline1.color)),
          ),
        ],
      ),
    );
  }
}

class ChangePasswordDialog extends StatefulWidget {
  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  List<Text> errors;
  // final _newPasswordKey = GlobalKey<TextForm
  final _newPasswordController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool hasError =false;
  bool isLoading =false;
  @override
  void dispose() {
    _newPasswordController.dispose();
    _oldPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    errors = new List<Text>();
  }

  Map<String, String> fields = {
    "oldpassword": "",
    "newpassword": "",
    "confirmpassword": ""
  };
  void _onFieldChange(String key, String value) {
    setState(() {
      fields[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(children:[Text("Change Password"),isLoading?CircularProgressIndicator():Container()]),
      content: Container(
        height: 350,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Current Password", style: TextStyle(color: Colors.black)),
              ),
              TextFormField(
               
                  // obscureText: true,
                  onChanged: (value) {
                    _onFieldChange("oldpassword", value);
                  },
                  controller: _oldPasswordController,
                  
                  validator: (value) {
                    if(hasError==true){
                      setState(() {
                        hasError=false;
                        isLoading =false;
                      });
                      return 'Incorrect Password';
                    }
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("New Password", style: TextStyle(color: Colors.black)),
              ),
              TextFormField(
                  // obscureText: true,
                  controller: _newPasswordController,
                  onChanged: (value) {
                    _onFieldChange("newpassword", value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    } else if (value.length <= 6) {
                      return 'Must be at least 6 characters long';
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Confirm New Password",
                    style: TextStyle(color: Colors.black)),
              ),
              TextFormField(
                  // obscureText: true,
                  onChanged: (value) {
                    _onFieldChange("confirmpassword", value);
                  },
                  controller: _confirmPasswordController,
                  validator: (value) {
                    print(_newPasswordController.value.text);
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    } else if (value != _newPasswordController.value.text) {
                      return "Password don't match";
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black)),
              
            ]),
          ),
        ),
      ),
      actions: [
        FlatButton(
            onPressed: () async {
              print("hello");
              if (_formKey.currentState.validate()) {
                setState((){
                  isLoading =true;
                });
                changePassword(fields).then((value){
                  print(value);
                  if(value=="Incorrect Password"){
                     setState((){
                      isLoading=true;
                      hasError = true;
                    });
                    _formKey.currentState.validate();
                  }else{
                   
                    Navigator.pop(context, true);
                  }

                }).catchError((error){
                  print(error);
                    setState((){
                      isLoading =true;
                      hasError = true;
                    });
                    _formKey.currentState.validate();
                });
              
              }

           
            },
            child: Text("Change")),
        FlatButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel")),
      ],
    );
  }
}
