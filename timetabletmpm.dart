import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'commons/BottomAppBar.dart';

class TimeTableMaker extends StatelessWidget {
  const TimeTableMaker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
      floatingActionButton: FloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 65.0,
            ),
            Icon(
              Icons.alarm,
              color: Colors.black,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              '시간표 수정',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Text(
              '알바 이름',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 10,
              cursorColor: Color(0xffFF6280),
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffFF6280)),
                  ),
                  hintText: '알바지 이름을 작성해주세요.'),
            ),
          ),
          Text(
            '요일',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 1,
              cursorColor: Color(0xffFF6280),
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffFF6280)),
                  ),
                  hintText: '요일을 작성해주세요 (예:월)'),
            ),
          ),
          Text(
            '시작 시간',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 5,
              cursorColor: Color(0xffFF6280),
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffFF6280)),
                  ),
                  hintText: '시작 시간을 작성해주세요. (예. 18:00)'),
            ),
          ),
          Text(
            '퇴근 시간',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 5,
              cursorColor: Color(0xffFF6280),
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffFF6280)),
                  ),
                  hintText: '퇴근 시간을 작성해주세요. (예. 18:00)'),
            ),
          ),
          Text(
            '색상',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.account_circle_outlined,
                    color: Colors.transparent),
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), primary: Colors.red),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.account_circle_outlined,
                    color: Colors.transparent),
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), primary: Colors.orange),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.account_circle_outlined,
                    color: Colors.transparent),
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), primary: Colors.yellow),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.account_circle_outlined,
                    color: Colors.transparent),
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), primary: Colors.green),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.account_circle_outlined,
                    color: Colors.transparent),
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), primary: Colors.blue),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Icon(Icons.account_circle_outlined,
                    color: Colors.transparent),
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), primary: Colors.purple),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:20,left:280.0),
            child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  '수정',
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xffFF6280))),
            ),
          )
        ],
      ),
    );
  }
}
