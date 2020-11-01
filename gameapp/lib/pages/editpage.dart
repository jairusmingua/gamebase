import 'package:flutter/material.dart';
import 'package:gameapp/class/avatars.dart';
import 'package:gameapp/class/user.dart';
import 'package:gameapp/widgets/avatarlist.dart';
import 'package:gameapp/widgets/registermain.dart';

class EditPage extends StatefulWidget {
  final User user;
  static const routeName = "/editpage";

  const EditPage({Key key, this.user}) : super(key: key);
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  void _onSubmit(Map<String, String> fields) {
    print(fields);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            )
          ],
          title: Text("Edit Profile",
              style: Theme.of(context).textTheme.bodyText2),
        ),
        body: EditPageBody(
          user: widget.user,
          onSubmit: _onSubmit,
        ));
  }
}

class EditPageBody extends StatefulWidget {
  final User user;
  final Function(Map<String, String>) onSubmit;

  const EditPageBody({Key key, this.onSubmit, this.user}) : super(key: key);

  @override
  _EditPageBodyState createState() => _EditPageBodyState();
}

class _EditPageBodyState extends State<EditPageBody> {
  Map<String, String> _fields;
  bool isLoading =false;
  @override
  void initState() {
    super.initState();
    setState(() {
      _fields = {
        "firstname": widget.user.firstName,
        "lastname": widget.user.lastName,
        "avatar": widget.user.avatar,
      };
    });
  }

  void _onApplyChanges() {
  
    setState(() {
      isLoading=true;
    });
    changeProfile(_fields).then((value){
      Navigator.pop(this.context);
    }).catchError((onError){
      Scaffold.of(this.context).showSnackBar(SnackBar(
        content:Text(onError.toString())
      ));
      setState(() {
        isLoading=false;
      });
    });
  }
  void _showAvatarDialog() {
    showDialog(
        context: this.context,
        useSafeArea: true,
        builder: (_) {
          return Dialog(
            child: Column(children: [
              Flexible(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "Choose Avatar",
                      style: Theme.of(this.context).textTheme.bodyText2,
                    ),
                  )),
              Flexible(
                flex: 10,
                child: AvatarList(
                  fields: _fields,
                  onChange: (val) {
                    setState(() {
                      _fields["avatar"] = val;
                    });
                  },
                ),
              ),
              Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(_);
                          },
                          child: Text("APPLY"))
                    ],
                  )),
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      // color: Colors.white,
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RawMaterialButton(
                        onPressed: _showAvatarDialog,
                        child: EditableIcon(
                            avatar: _fields["avatar"], height: 90, width: 90)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  child: Column(children: [
                    Row(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                               onChanged: (val){setState((){
                                    _fields["firstname"]=val;
                                });},
                                style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                    hintText: widget.user.firstName,
                                    hintStyle: TextStyle(color: Colors.white))),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                onChanged: (val){setState((){
                                    _fields["lastname"]=val;
                                });},
                                style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                    hintText: widget.user.lastName,
                                    hintStyle: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: _onApplyChanges, child: Text("APPLY"))
                        ],
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
          isLoading?Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black54,
            child: Stack(
              children: [
                Positioned(
                  // top:25,
                  bottom: 150,
                  left: 25,
                  right: 25,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ):Container()
        ],
      ),
    );
  }
}

class EditableIcon extends StatelessWidget {
  final String avatar;
  final double height;
  final double width;

  const EditableIcon({Key key, this.avatar, this.height, this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double borderWidth = 3;
    return Container(
      height: this.height,
      width: this.width + (borderWidth * 2),
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
              // color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.red, width: borderWidth)),
          child: RoundedIcon(
              avatar: this.avatar, height: this.height, width: this.width),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: 30,
            width: 30,
            child: Icon(
              Icons.edit,
              size: 20,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 3)),
          ),
        ),
      ]),
    );
  }
}

class RoundedIcon extends StatelessWidget {
  final String avatar;
  final double height;
  final double width;
  const RoundedIcon(
      {Key key,
      @required this.avatar,
      @required this.height,
      @required this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: new NetworkImage(convertAvatarToUrl(avatar)),
          )),
    );
  }
}
