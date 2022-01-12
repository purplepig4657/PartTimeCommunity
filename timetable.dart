import 'package:flutter_timetable_view/flutter_timetable_view.dart';
import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {
  TimeTable({
    required this.Mon,
    required this.Tue,
    required this.Wed,
    required this.Thu,
    required this.Fri,
    required this.Sat,
    required this.Sun,
  });
  final List<TableEvent> Mon;
  final List<TableEvent> Tue;
  final List<TableEvent> Wed;
  final List<TableEvent> Thu;
  final List<TableEvent> Fri;
  final List<TableEvent> Sat;
  final List<TableEvent> Sun;

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {


  @override
  Widget build(BuildContext context) {
    return TimetableView(
      laneEventsList: _buildLaneEvents(),
      timetableStyle: const TimetableStyle(timeItemHeight: 50, timeItemWidth: 45, laneWidth: 45,),
    );
  }

  List<LaneEvents> _buildLaneEvents() {
    return [

      LaneEvents(
        lane: Lane(name: '일', width: 45, height: 30),
        events: widget.Sun,
      ),
      LaneEvents(
        lane: Lane(name: '월', width: 45, height: 30),
        events: widget.Mon,
      ),
      LaneEvents(
        lane: Lane(name: '화', width: 45, height: 30),
        events: widget.Tue,
      ),
      LaneEvents(
        lane: Lane(name: '수', width: 45, height: 30),
        events: widget.Wed,
      ),
      LaneEvents(
        lane: Lane(name: '목', width: 45, height: 30),
        events: widget.Thu,
      ),
      LaneEvents(
        lane: Lane(name: '금', width: 45, height: 30),
        events: widget.Fri,
      ),
      LaneEvents(
        lane: Lane(name: '토', width: 45, height: 30),
        events: widget.Sat,
      ),
    ];
  }
}
