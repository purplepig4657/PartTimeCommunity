import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Personal extends StatefulWidget {
  const Personal({Key? key,
    required this.signOut}) : super(key: key);

  final void Function() signOut;

  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 350,
        height: 500,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
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
                    margin: const EdgeInsets.fromLTRB(15, 30, 10, 20),
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('images/anonymous.jpg'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left:20),
                    child: Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: FirebaseAuth.instance.currentUser!.displayName,
                            children: const <TextSpan>[
                              TextSpan(text: '님', style: TextStyle(fontStyle: FontStyle.normal,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const Text('안녕하세요!',style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: const Color(0xffFFE9ED),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                title: const Text('회원정보 수정'),
                trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    color: const Color(0xffFF6280)),
              ),
            ),
            Card(
              color: const Color(0xffFFE9ED),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                title: const Text('내가 올린 게시글'),
                trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    color: const Color(0xffFF6280)),
              ),
            ),
            Card(
              color: const Color(0xffFFE9ED),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                title: const Text('앱 정보'),
                trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                    color: const Color(0xffFF6280)),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom
                (padding: const EdgeInsets.all(20.0),
                primary: Colors.red,
                textStyle: const TextStyle(fontSize:15),),
              onPressed: () {
                widget.signOut();
              },
              child: const Text('로그아웃'),
            ),
          ],
        ),
      ),
    );
  }
}
