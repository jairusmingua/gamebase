import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gameapp/class/game.dart';

class GamePageAppBar extends SliverPersistentHeaderDelegate {
  GamePageAppBar({this.game,this.appBar });
  final Game game;
  final AppBar appBar;
  @override
  Widget build(
    BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      // color: Colors.black.withOpacity(titleOpacity(shrinkOffset)),
      children: [
        Container(color: Colors.black.withOpacity(titleOpacity(shrinkOffset))),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: shrinkOffset,
            child: Container(
              // height: 50,
              color: Colors.black,
            )),
        appBar,
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(1.0, shrinkOffset) / (maxExtent);
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => appBar.preferredSize.height + 30;

  @override
  double get minExtent => appBar.preferredSize.height + 30;
}
