import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'commons/BottomAppBar.dart';

class Review extends StatelessWidget {
  const Review({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: Colors.black,)),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.reviews,
              color: Colors.black,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text('REVIEW', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20.0),
            child: responsive('온누리 약국'),
          ),
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 30,
                ),
                responsiveCard("ooooooooo"),
              ],
            ),
          )
        ],
      ),

      /** AppBar **/
      bottomNavigationBar: BottomBar(),
      floatingActionButton: FloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      /** AppBar **/
    );
  }

  Widget responsive(String s) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xffFF6082),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Flexible(
        fit: FlexFit.tight,
        child: Text(
          s,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
  Widget responsiveCard(String s) {
    return Container(
      padding: EdgeInsets.only(top:20,bottom:20,right:15,left:15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ), border: Border.all(
        color: Colors.black,
        style: BorderStyle.solid,
        width: 0.5,
      )
      ),
      child: Flexible(
        fit: FlexFit.tight,
        child: Text(
          s,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
