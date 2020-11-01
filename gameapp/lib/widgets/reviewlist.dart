import 'package:flutter/material.dart';
import 'package:gameapp/class/review.dart';
import 'package:gameapp/class/user.dart';

import 'gamecard.dart';


class ReviewList extends StatefulWidget {
  ReviewList({this.user});
  final User user;
  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchUserReview(widget.user.userId),
      builder: (context, AsyncSnapshot<List<Review>> snapshot) {
        if (snapshot.hasError) print(snapshot.error);

        return snapshot.hasData
            ? ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ReviewCards(review: snapshot.data[index]);
                })
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
 
  }
}

class ReviewCards extends StatelessWidget {
  ReviewCards({this.review});
  final Review review;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: EdgeInsets.all(5),
      color: Theme.of(context).backgroundColor,
      child: Row(
        children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Gamecard(
                game: review.game,
                hasLabels: false,
              )),
          Flexible(
              fit: FlexFit.tight,
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(review.game.gameTitle),
                        ),
                        Flexible(
                                                  child: Text(
                            review.reviewText,
                            style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ]),
                ),
              )),
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Container(
                // color:Colors.yellow,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [
                        Icon(
                          Icons.star,
                          size: 40,
                          color: Colors.yellow,
                        ),
                        Text(review.starRating.toString() + "/5")
                      ]),
                    ]),
              ))
        ],
      ),
    );
  }
}
