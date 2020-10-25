import 'package:flutter/material.dart';



class RatingPanel extends StatefulWidget {
  RatingPanel({this.onChange});
  final Function(int) onChange;
  @override
  _RatingPanelState createState() => _RatingPanelState();
}

class _RatingPanelState extends State<RatingPanel> {
  List<GestureDetector>stars;
  Color notpress = Colors.grey;
  IconData buttonStyle = Icons.star;
  Color pressed = Colors.yellow;
  double size = 40;
  int rating =-1;
  void ratingSelected(int index){
     setState((){
       rating = index;
     });
     widget.onChange(index);
  }
  @override
  void initState(){
    super.initState();
  
  } 
  @override
  Widget build(BuildContext context) {
    
    stars = [
        GestureDetector(
          child: Icon(
            buttonStyle,
            size: size,
            color: rating>=(1)?pressed:notpress,
          ),
          onTap: (){ratingSelected(1);},
        ),
        GestureDetector(
          child: Icon(
            buttonStyle,
            size: size,
            color: rating>=(2)?pressed:notpress,
          ),
          onTap: (){ratingSelected(2);},
        ),
        GestureDetector(
          child: Icon(
            buttonStyle,
            size: size,
            color: rating>=(3)?pressed:notpress,
          ),
          onTap: (){ratingSelected(3);},
        ),
        GestureDetector(
          child: Icon(
            buttonStyle,
            size: size,
            color: rating>=(4)?pressed:notpress,
          ),
          onTap: (){ratingSelected(4);},
        ),
        GestureDetector(
          child: Icon(
            buttonStyle,
            size: size,
            color: rating>=(5)?pressed:notpress,
          ),
          onTap: (){ratingSelected(5);},
        ),
       
    ];
    return Container(
      child:Row(
        crossAxisAlignment:CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: stars,
      )
    );
  }
}