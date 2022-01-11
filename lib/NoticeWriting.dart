import 'package:flutter/material.dart';
import 'commons/BottomAppBar.dart';

class NoticeWriting extends StatelessWidget {
  const NoticeWriting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: Colors.black,)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30.0,
            ),
            Icon(
              Icons.calendar_today_rounded,
              color: Colors.black,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              '글 작성',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_box_outlined),
            color: Colors.black,
            iconSize: 30,
          )
        ],
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 550,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
              border: Border.all(
                color: Colors.black,
                style: BorderStyle.solid,
                width: 0.5,
              )),
          child: ListView(
            children: [
              ListTile(
                  title: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                maxLength: 20,
                cursorColor: Color(0xffFF6280),
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFF6280)),
                    ),
                    hintText: '제목을 입력하세요.'),
              )),
              Divider(),
              ListTile(
                  title: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                maxLength: 1000,
                cursorColor: Color(0xffFF6280),
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFF6280)),
                    ),
                    hintText: '내용을 입력하세요.'),
              )),
            ],
          ),
        ),
      ),

      /** AppBar **/
      bottomNavigationBar: BottomBar(),
      floatingActionButton: FloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      /** AppBar **/
    );
  }
}
