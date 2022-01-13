import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../app.dart';

class Review extends StatefulWidget {
  const Review({Key? key,
    required this.startWriteReview,
    required this.reviewContent}) : super(key: key);

  final void Function() startWriteReview;
  final List<ReviewContent> reviewContent;


  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  List<ReviewContent> list = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  responsive('스타벅스 충남대점'),
                  ElevatedButton(
                    onPressed: () {
                      widget.startWriteReview();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xffFF9DAF)),
                    ),
                    child: const Text(
                      '리뷰 작성',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: _buildContent(),
                ),
              ),
           const SizedBox(
              height: 150,
            ),
          ],
        ));
  }

  Widget _buildContent() {
    list = widget.reviewContent;
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      itemCount: widget.reviewContent.length,
      itemBuilder: (context, i) {
        Timestamp time = Timestamp.fromMicrosecondsSinceEpoch(list[i].date);
        return responsiveCard(list[i].content, time.toDate().toString());
      },
    );
  }

  Widget responsive(String s) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Color(0xffFF6082),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Flexible(
        fit: FlexFit.tight,
        child: Text(
          s,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget responsiveCard(String s, String time) {
    return Container(
      padding: const EdgeInsets.only(top: 25, bottom: 20, right: 15, left: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          border: Border.all(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 0.5,
          )),
      child: Flexible(
        fit: FlexFit.tight,
        child: Column(
          children: [
            Text(
              s,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 250),
              child: Text(
                time,
                style: const TextStyle(color: Colors.black, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
