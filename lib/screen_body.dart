import 'package:flutter/material.dart';
import 'package:part_time_community_2/app.dart';
import 'pages/free_board.dart';
import 'pages/write_content.dart';
import 'pages/read_content.dart';
import 'pages/personal.dart';
import 'pages/map.dart';
import 'pages/review.dart';
import 'pages/write_review.dart';


enum ApplicationBodyState {
  login,
  logout,
  home,
  free_board,
  write_content,
  read_content,
  write_review,
  review,
  message,
  timetable,
  personal,
  personal_setting,
  map
}

class ScreenBody extends StatelessWidget {
  ScreenBody({
    required this.bodyState,
    required this.freeBoardContent,
    required this.email,
    required this.startLoginFlow,
    required this.startHome,
    required this.startBoard,
    required this.startWriteContent,
    required this.startReadContent,
    required this.selectContent,
    required this.selectedContent,
    required this.startMessage,
    required this.startTimetable,
    required this.startPersonal,
    required this.startPersonalSetting,
    required this.startMap,
    required this.startReview,
    required this.startWriteReview,
    required this.reviewContent,
    required this.startPrevious,
    required this.signOut,
  });

  final ApplicationBodyState bodyState;
  final List<BoardContent> freeBoardContent;
  final String? email;
  final void Function() startLoginFlow;
  final void Function() startHome;
  void Function(int) startBoard;
  final void Function() startWriteContent;
  final void Function() startReadContent;
  final void Function(BoardContent) selectContent;
  final BoardContent selectedContent;
  final void Function() startMessage;
  final void Function() startTimetable;
  final void Function() startPersonal;
  final void Function() startPersonalSetting;
  final void Function() startMap;
  final void Function() startReview;
  final void Function() startWriteReview;
  final List<ReviewContent> reviewContent;
  final void Function() startPrevious;
  final void Function() signOut;


  @override
  Widget build(BuildContext context) {
    switch (bodyState) {
      case ApplicationBodyState.home:
        return Home(startBoard: startBoard,);
      case ApplicationBodyState.message:
        return Row(
          children: [Text("Message"),],
        );
      case ApplicationBodyState.timetable:
        return Row(
          children: [Text("Timetable"),],
        );
      case ApplicationBodyState.personal:
        return Personal(signOut: signOut,
          startPersonalSetting: startPersonalSetting,);
      case ApplicationBodyState.personal_setting:
        return PersonalSetting();
      case ApplicationBodyState.map:
        return Map(startReview: startReview,);
      case ApplicationBodyState.review:
        return Review(startWriteReview: startWriteReview,
          reviewContent: reviewContent,);
      case ApplicationBodyState.write_review:
        return WriteReview(startPrevious: startPrevious,);
      case ApplicationBodyState.free_board:
        return FreeBoard(
          freeBoardContent: freeBoardContent,
          startWriteContent: startWriteContent,
          startReadContent: startReadContent,
          selectContent: selectContent,
        );
      case ApplicationBodyState.write_content:
        return WriteContent(startPrevious: startPrevious,);
      case ApplicationBodyState.read_content:
        return ReadContent(selectContent: selectedContent,);
      default:
        return Row();
    }
  }
}

class Home extends StatelessWidget {
  Home({Key? key,
    required this.startBoard}) : super(key: key);

  void Function(int) startBoard;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0.0),
          child: Row(
            children: const [
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
        const SizedBox(
          height: 10.0,
        ),
        const Center(
          child: Image(
            fit: BoxFit.fill,
            width: 350,
            height: 200,
            image: AssetImage('images/map.jpg'),
          ),
        ),
        /*
        ElevatedButton(
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),primary: const Color(0xffFF6280), // background// foreground
            ),
            child: Row(
              children: const [
                Icon(Icons.search),
                SizedBox(width: 10.0,),
                Text('동네 찾기'),
              ],
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('동네 찾기 성공!',
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            }),
        const SizedBox(
          height: 5.0,
        ),
        */
        Container(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
          child: Row(
            children: const [
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
        const SizedBox(
          height: 10.0,
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30.0),
                ),
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 0.5,
                )),
            width: 330,
            height: 230,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListView(
                children: [
                  ListTile(title: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () {
                      startBoard(1);
                    },
                    child: const Text('자유 게시판', style: TextStyle(color: Colors.black,),),
                  )),
                  ListTile(title: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/Second');
                    },
                    child: const Text('대타 게시판', style: TextStyle(color: Colors.black,),),
                  )),
                  ListTile(title: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/Second');
                    },
                    child: const Text('정보 게시판', style: TextStyle(color: Colors.black,),),
                  )),
                  ListTile(title: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/Second');
                    },
                    child: const Text('직종별 게시판', style: TextStyle(color: Colors.black,),),
                  )),

                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50.0,
        ),
      ],
    );
  }
}
