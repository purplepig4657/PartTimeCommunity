import 'package:flutter/material.dart';
import 'screen_body.dart';

class BackNotifier extends StatelessWidget {
  BackNotifier({Key? key,
    required this.startPrevious,
    required this.bodyState}) : super(key: key);

  ApplicationBodyState bodyState;
  final void Function() startPrevious;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if(bodyState != ApplicationBodyState.home) {
            print(bodyState);
            startPrevious();
          }
        },
        icon: const Icon(Icons.arrow_back,color: Colors.black,)
    );
  }
}

class TitleNotifier extends StatelessWidget {
  const TitleNotifier({Key? key,
    required this.bodyState}) : super(key: key);

  final ApplicationBodyState bodyState;

  @override
  Widget build(BuildContext context) {
    switch(bodyState) {
      case ApplicationBodyState.home:
        return const Text(
          'HOME',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );
      case ApplicationBodyState.free_board:
        return const Text(
          '자유게시판',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );
      case ApplicationBodyState.write_content:
        return const Text(
          '글 작성',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );
      case ApplicationBodyState.read_content:
        return const Text(
          '글 읽기',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );
      case ApplicationBodyState.message:
        return const Text(
          '채팅',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );
      case ApplicationBodyState.timetable:
        return const Text(
          '시간표',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );
      case ApplicationBodyState.personal:
        return const Text(
          '개인정보',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );
      case ApplicationBodyState.map:
        return const Text(
          '후기지도',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );
      case ApplicationBodyState.review:
        return const Text(
          '리뷰',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );
      case ApplicationBodyState.logout:
        return const Text(
          '로그인',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );
      default:
        return const Text(
          'HOME',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        );
    }
  }
}