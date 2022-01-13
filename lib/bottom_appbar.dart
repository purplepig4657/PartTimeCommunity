import 'package:flutter/material.dart';

import 'screen_body.dart';

class BottomBar extends StatefulWidget {
  BottomBar(
      {Key? key,
        this.home_selected = false,
        this.message_selected = false,
        this.timeTable_selected = false,
        this.personal_selected = false,
        required this.func_home, required this.func_message,
        required this.func_timetable, required this.func_personal,})
      : super(key: key);

  bool home_selected, message_selected, timeTable_selected, personal_selected;
  final void Function() func_home;
  final void Function() func_message;
  final void Function() func_timetable;
  final void Function() func_personal;


  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: IconButton(
              icon: widget.home_selected
                  ? const Icon(
                Icons.home_outlined,
                color: const Color(0xFFFF6281),
              )
                  : const Icon(Icons.home_outlined),
              onPressed: () {
                if(widget.home_selected != true) {
                  widget.func_home();
                  widget.home_selected = !widget.home_selected;
                }
              },
              iconSize: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: IconButton(
              icon: widget.message_selected
                  ? const Icon(
                Icons.message_outlined,
                color: const Color(0xFFFF6281),
              )
                  : const Icon(Icons.message_outlined),
              onPressed: () {
                if(widget.message_selected != true) {
                  widget.func_message();
                  widget.message_selected = !widget.message_selected;
                }
              },
              iconSize: 30,
            ),
          ),
          const SizedBox(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: IconButton(
              icon: widget.timeTable_selected
                  ? const Icon(
                Icons.alarm_outlined,
                color: const Color(0xFFFF6281),
              )
                  : const Icon(Icons.alarm_outlined),
              onPressed: () {
                if(widget.timeTable_selected != true) {
                  widget.func_timetable();
                  widget.timeTable_selected = !widget.timeTable_selected;
                }
              },
              iconSize: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: IconButton(
              icon: widget.personal_selected
                  ? const Icon(
                Icons.person_outline,
                color: const Color(0xFFFF6281),
              )
                  : const Icon(Icons.person_outline),
              onPressed: () {
                if(widget.personal_selected != true) {
                  widget.func_personal();
                  widget.personal_selected = !widget.personal_selected;
                }
              },
              iconSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}


class BottomBarNotifier extends StatelessWidget {
  BottomBarNotifier({
    required this.bodyState,
    required this.startHome,
    required this.startBoard,
    required this.startMessage,
    required this.startTimetable,
    required this.startPersonal,
    required this.startMap,
  });

  final ApplicationBodyState bodyState;
  final void Function() startHome;
  void Function(int) startBoard;
  final void Function() startMessage;
  final void Function() startTimetable;
  final void Function() startPersonal;
  final void Function() startMap;

  @override
  Widget build(BuildContext context) {
    switch(bodyState) {
      case ApplicationBodyState.home:
        return BottomBar(
          home_selected: true,
          func_home: startHome,
          func_message: startMessage,
          func_timetable: startTimetable,
          func_personal: startPersonal,

        );
      case ApplicationBodyState.message:
        return BottomBar(
          message_selected: true,
          func_home: startHome,
          func_message: startMessage,
          func_timetable: startTimetable,
          func_personal: startPersonal,
        );
      case ApplicationBodyState.timetable:
        return BottomBar(
          timeTable_selected: true,
          func_home: startHome,
          func_message: startMessage,
          func_timetable: startTimetable,
          func_personal: startPersonal,
        );
      case ApplicationBodyState.personal:
        return BottomBar(
          personal_selected: true,
          func_home: startHome,
          func_message: startMessage,
          func_timetable: startTimetable,
          func_personal: startPersonal,
        );
      default:
        return BottomBar(
          func_home: startHome,
          func_message: startMessage,
          func_timetable: startTimetable,
          func_personal: startPersonal,
        );
    }

  }
}

class FloatingButtonNotifier extends StatelessWidget {
  const FloatingButtonNotifier({
    required this.bodyState,
    required this.previousState,
    required this.startPrevious,
    required this.startMap,
  });

  final ApplicationBodyState bodyState;
  final ApplicationBodyState previousState;
  final void Function() startPrevious;
  final void Function() startMap;

  @override
  Widget build(BuildContext context) {
    if(bodyState == ApplicationBodyState.map) {
      return FloatingButton(
        isSelected: true,
        startMap: startMap,
        startPrevious: startPrevious,
      );
    } else {
      return FloatingButton(startMap: startMap, startPrevious: startPrevious,);
    }

  }
}

class FloatingButton extends StatefulWidget {
  FloatingButton({Key? key,
    this.isSelected = false,
    required this.startMap, required this.startPrevious}) : super(key: key);

  bool isSelected;
  final void Function() startMap;
  final void Function() startPrevious;

  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        widget.startPrevious();
      },
      backgroundColor: const Color(0xFFFF6281),
    );
  }
}
