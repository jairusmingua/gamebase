import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _storage = FlutterSecureStorage();
  
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  void _logout() async {
    await _storage.write(key: "isLoggedIn", value: "false");
    await _storage.delete(key: "access_token");
    Navigator.pop(_scaffold.currentContext);
  }
  void _showLogout(){
    showDialog(context: _scaffold.currentContext,
      builder: (_)=>AlertDialog(
        title: Text("Logout"),
        content: Text("Do you really want to logout?",style:TextStyle(color:Colors.black)),
        actions: [
          FlatButton(onPressed: _logout, child: Text("Yes")),
          FlatButton(onPressed:()=>Navigator.pop(_scaffold.currentContext), child: Text("No")),

        ],
      )
    );
  }
  void _showAbout(){
    showAboutDialog(context: _scaffold.currentContext,
      applicationName: "🎮 GameBase",
      applicationVersion: "0.0.0-alpha.1",
      applicationLegalese: "A project in fulfillment for Dotnet 4\nSubmitted by:\n\nJairus Mingua\nJerome Desiderio\nJaps Tribiana"
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    TextStyle _style = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      key:_scaffold,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 90,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: SafeArea(child: SettingHeader()),),
      body: Container(
        child: ListView(
          children:[
            ListTile(
              leading: Icon(Icons.vpn_key,color: Colors.white,),
              title:Text("Change Password",style: _style,),
              onTap: ()=>print("tap"),
            ),
            ListTile(
              leading: Icon(Icons.logout,color: Colors.white,),
              title:Text("Logout",style: _style,),
              onTap: _showLogout,
            ),
            ListTile(
              leading: Icon(Icons.group,color: Colors.white,),
              title:Text("About Us",style: _style,),
              onTap:_showAbout,
            ),
          ]
        ),
      ) 
    );
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
