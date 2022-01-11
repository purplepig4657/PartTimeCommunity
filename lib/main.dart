import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:part_time_community/NoticeWriting.dart';
import 'package:part_time_community/Review.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mijung',
      theme: ThemeData(primaryColor: Color(0xffFF6280)),
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HOME',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
            child: Row(
              children: [
                Icon(Icons.map, size: 25.0),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '후기 지도',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Center(
            child: Image(
              fit: BoxFit.fill,
              width: 350,
              height: 200,
              image: AssetImage('images/map.jpg'),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
            child: Row(
              children: [
                Icon(Icons.calendar_today_rounded, size: 25.0),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '게시판',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  border: Border.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 0.5,
                  )),
              width: 350,
              height: 230,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: ListView(
                  children: [
                    ListTile(title: Text('자유 게시판')),
                    ListTile(title: Text('대타 게시판')),
                    ListTile(title: Text('정보 게시판')),
                    ListTile(title: Text('직종별 게시판')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 70.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  icon: Icon(Icons.home_outlined),
                  iconSize: 30,
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.palette_outlined),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NoticeWriting()),
                    );
                  }),
              SizedBox(),
              IconButton(
                  icon: Icon(Icons.message_outlined),
                  iconSize: 30,
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.account_circle_outlined),
                  iconSize: 30,
                  onPressed: () {}),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
        backgroundColor: Color(0xffFF6028),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
