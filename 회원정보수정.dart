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
        title: Center(
          child: Row(
            children: [
              SizedBox(
                width: 110.0,
              ),
              Icon(
                Icons.account_box_outlined,
                color: Colors.black,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                '회원정보 수정',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
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
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          Text(
                            'Randall3791',
                            style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.add_box_sharp),
                                  iconSize: 20,
                                  color: Color(0xffFF6280),
                                  onPressed: () {}),
                              Text(
                                '이름 수정',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '이메일을 입력하세요',
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '전화번호를 입력하세요',
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '비밀번호를 입력하세요',
                    )),
                  )
                ],
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
                  icon: Icon(Icons.palette_outlined),
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
        child: Icon(Icons.add),
        onPressed: () {},
        backgroundColor: Color(0xffFF6280),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
  Widget responsive(String s) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffFF6082),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: TextButton(
        onPressed: () {},
        child: Flexible(
          fit: FlexFit.loose,
          child: Text(
            s,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
