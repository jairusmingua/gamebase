import 'package:flutter/material.dart';
import 'package:gameapp/class/avatars.dart';
class AvatarList extends StatefulWidget {
  AvatarList({this.fields,this.onChange});
  final Map<String,String>fields;
  final Function(String)onChange;
  @override
  _AvatarListState createState() => _AvatarListState();
}

class _AvatarListState extends State<AvatarList> {
  @override
  void initState() {
    super.initState();
    fetchAvatars().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchAvatars(),
      builder: (BuildContext context, AsyncSnapshot<List<Avatar>> snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? SelectableGrid(
                onClick:(Avatar avatar){widget.onChange(avatar.name);},
                items: snapshot.data)
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

class SelectableGrid extends StatefulWidget {
  SelectableGrid({@required this.onClick, this.items});
  final Function(Avatar) onClick;
  final List<Avatar> items;

  @override
  _SelectableGridState createState() => _SelectableGridState();
}

class _SelectableGridState extends State<SelectableGrid> {
  int selectedIndex = -1;
  void _gridClick(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onClick(widget.items[index]);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridTile(
              child: InkResponse(
                onTap: () {
                  _gridClick(index);
                },
                child: Stack(
                  children: [
                    Container(
                      color: index == selectedIndex ? Colors.black : null,
                    ),
                    Container(
                        decoration: BoxDecoration(
                      // color: Colors.black,

                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: new NetworkImage(
                            convertAvatarToUrl(widget.items[index].name),
                          )),
                    )),
                  ],
                ),
              ),
            ),
          );
        });
  }
}