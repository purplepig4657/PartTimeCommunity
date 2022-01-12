import 'package:flutter/material.dart';

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
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30.0,
            ),
            Icon(
              Icons.account_box_outlined,
              color: Colors.black,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              '내 정보',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          width: 350,
          height: 500,
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
                title: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 30, 10, 20),
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('images/cat.jpg'),
                            fit: BoxFit.fill),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left:20),
                      child: Column(
                        children: [
                          const Text.rich(
                            TextSpan(
                              text: 'Randall3791',
                              children: <TextSpan>[
                                TextSpan(text: '님', style: TextStyle(fontStyle: FontStyle.normal,fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Text('안녕하세요!',style: TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                color: Color(0xffFFE9ED),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  title: Text('회원정보 수정'),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                      color: Color(0xffFF6280)),
                ),
              ),
              Card(
                color: Color(0xffFFE9ED),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  title: Text('내가 올린 게시글'),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                      color: Color(0xffFF6280)),
                ),
              ),
              Card(
                color: Color(0xffFFE9ED),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  title: Text('앱 정보'),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                      color: Color(0xffFF6280)),
                ),
              ),
            ],
          ),
        ),
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
                  icon: Icon(Icons.alarm_outlined),
                  iconSize: 30,
                  onPressed: () {}),
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
        child: Icon(Icons.navigation),
        onPressed: () {},
        backgroundColor: Color(0xffFF6280),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
