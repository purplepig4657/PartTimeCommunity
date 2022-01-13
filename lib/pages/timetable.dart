import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:flutter_timetable_view/flutter_timetable_view.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class DBHelper {

  static dynamic database;

  void initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'TimeTable.db');
    database = await openDatabase(
        path,
        version : 1,
        onCreate: (db, version) async {
          await db.execute(
            "CREATE TABLE Schedule("
                "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
                "day Text, "
                "startHour INTEGER, "
                "startMin INTEGER, "
                "endHour INTEGER, "
                "endMin INTEGER, "
                "title Text, "
                "color INTEGER)",
          );
        }
    );
  }

  Future<int> insertSchedule(Schedule sc) async {
    // 데이터베이스 reference를 얻습니다.

    // Dog를 올바른 테이블에 추가하세요. 또한
    // `conflictAlgorithm`을 명시할 것입니다. 본 예제에서는
    // 만약 동일한 dog가 여러번 추가되면, 이전 데이터를 덮어쓸 것입니다.
    int v = await database.rawInsert('INSERT INTO Schedule(day, startHour, startMin, endHour, endMin, title, color) VALUES(?, ?, ?, ?, ?, ?, ?)',
        [sc.day, sc.startHour, sc.startMin, sc.endHour, sc.endMin, sc.title, sc.color.value]);
    print('inserted id $v');
    return v;

    // await db.insert(
    //   'Schedule',
    //   sc.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
  }

  Future<List<Schedule>> schedules(String day) async {
    // 데이터베이스 reference를 얻습니다.

    // 모든 Dog를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await database.query('Schedule', where: 'day = ?', whereArgs: [day]);

    //await database.query('Schedule', where: "day=`$day`");

    // List<Map<String, dynamic>를 List<Dog>으로 변환합니다.
    return List.generate(maps.length, (i) {
      print('db id: ${maps[i]['id']}, title: ${maps[i]['title']}');
      return Schedule(
        id: maps[i]['id'],
        startHour: maps[i]['startHour'],
        startMin: maps[i]['startMin'],
        endHour: maps[i]['endHour'],
        endMin: maps[i]['endMin'],
        title: maps[i]['title'],
        color: Color(maps[i]['color']),
        day: maps[i]['day'],
      );
    });
  }

  Future<void> deleteSchedule(int id) async {
    // 데이터베이스 reference를 얻습니다.

    // 데이터베이스에서 Dog를 삭제합니다.
    await database.delete(
      'Schedule',
      // 특정 dog를 제거하기 위해 `where` 절을 사용하세요
      where: "id = ?",
      // Dog의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
      whereArgs: [id],
    );
  }
}


class EditTimeContent extends StatefulWidget {
  const EditTimeContent(this.schedule, this.startPrevious);
  final Schedule? schedule;
  final void Function() startPrevious;

  @override
  _EditTimeContentState createState() => _EditTimeContentState();
}

class _EditTimeContentState extends State<EditTimeContent> {
  final List<Color> colors = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple];
  final _formKey = GlobalKey<FormState>(debugLabel: '_EditTimeContentState');
  final _startC = TextEditingController();
  final _endC = TextEditingController();
  final _titleC = TextEditingController();
  final _dayC = TextEditingController();
  int selectedColor = 0;

  @override
  void initState(){
    super.initState();
    if(widget.schedule != null){
      String convert = '?';
      switch(widget.schedule!.day){
        case 'Mon':
          convert = '월';
          break;
        case 'Tue':
          convert = '화';
          break;
        case 'Wed':
          convert = '수';
          break;
        case 'Thu':
          convert = '목';
          break;
        case 'Fri':
          convert = '금';
          break;
        case 'Sat':
          convert = '토';
          break;
        case 'Sun':
          convert = '일';
          break;
      }
      _startC.text = '${widget.schedule!.startHour}:${widget.schedule!.startMin}';
      _endC.text = '${widget.schedule!.endHour}:${widget.schedule!.endMin}';
      _titleC.text = widget.schedule!.title;
      _dayC.text = convert;
      selectedColor = colors.indexOf(widget.schedule!.color);
    }
  }

  String? checkValidate(String type, String? value){
    if(value!.isEmpty) return '값을 입력해주세요.';
    if(type=='day') {
      Map<String, String> convert = {
        '일': 'Sun',
        '월': 'Mon',
        '화': 'Tue',
        '수': 'Wed',
        '목': 'Thu',
        '금': 'Fri',
        '토': 'Sat'
      };
      if(!convert.keys.contains(value)) return '요일이 올바르지 않습니다.';
    }else if(type=='start'){
      try {
        List<int> start = _startC.text.split(':').map(int.parse).toList();
        if(start[0] < 0 || start[0] > 23 || start[1] < 0 || start[1] > 59) throw '';
      }catch(e){ return '시간을 알맞게 입력해주세요.'; }
    }else if (type=='end'){
      try {
        List<int> start = _startC.text.split(':').map(int.parse).toList();
        List<int> end = _endC.text.split(':').map(int.parse).toList();
        if(start[0] < 0 || start[0] > 23 || start[1] < 0 || start[1] > 59) throw '';
        if(end[0] < 0 || end[0] > 23 || end[1] < 0 || end[1] > 59) throw '';
        if(start[0]*60 + start[1] >= end[0]*60 + end[1]) return '퇴근 시간이 올바르지 않습니다.';
      }catch(e){ return '시간을 알맞게 입력해주세요.'; }
    }
    return null;
  }

  void ok(){
    if(_formKey.currentState!.validate()) {
      var db = DBHelper();
      print('!isNull? ${widget.schedule!=null}');
      if(widget.schedule!=null){
        print('deleted ${widget.schedule!.id}');
        db.deleteSchedule(widget.schedule!.id);
      }

      List<int> start = _startC.text.split(':').map(int.parse).toList();
      List<int> end = _endC.text.split(':').map(int.parse).toList();

      String convert = '?';
      switch(_dayC.text){
        case '월':
          convert = 'Mon';
          break;
        case '화':
          convert = 'Tue';
          break;
        case '수':
          convert = 'Wed';
          break;
        case '목':
          convert = 'Thu';
          break;
        case '금':
          convert = 'Fri';
          break;
        case '토':
          convert = 'Sat';
          break;
        case '일':
          convert = 'Sun';
          break;
      }
      print('convert $convert');
      if(convert!='?') {
        db.insertSchedule(Schedule(id: -1,
            // dump value(id) < AUTOINCREMENT
            startHour: start[0],
            startMin: start[1],
            endHour: end[0],
            endMin: end[1],
            title: _titleC.text,
            color: colors[selectedColor],
            day: convert));
      }

      widget.startPrevious();
    }
  }

  void SelectColor(int idx) {
    setState(() {
      selectedColor = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Text(
              '알바 이름',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: _titleC,
              validator: (value) { if(value!.isEmpty) { return '알바지를 입력해주세요.'; } return null; },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 10,
              cursorColor: const Color(0xffFF6280),
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffFF6280)),
                  ),
                  hintText: '알바지 이름을 작성해주세요.'),
            ),
          ),
          const Text(
            '요일',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: _dayC,
              validator: (value) => checkValidate('day', value),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 1,
              cursorColor: const Color(0xffFF6280),
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffFF6280)),
                  ),
                  hintText: '요일을 작성해주세요 (예:월)'),
            ),
          ),
          const Text(
            '시작 시간',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: _startC,
              validator: (value) => checkValidate('start', value),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 5,
              cursorColor: Color(0xffFF6280),
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffFF6280)),
                  ),
                  hintText: '시작 시간을 작성해주세요. (예. 18:00)'),
            ),
          ),
          const Text(
            '퇴근 시간',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: _endC,
              validator: (value) => checkValidate('end', value),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 5,
              cursorColor: Color(0xffFF6280),
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffFF6280)),
                  ),
                  hintText: '퇴근 시간을 작성해주세요. (예. 18:00)'),
            ),
          ),
          const Text(
            '색상',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
            List.generate(colors.length, (i) => ElevatedButton(
              onPressed: () { SelectColor(i); },
              child: const Icon(Icons.account_circle_outlined,
                  color: Colors.transparent),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(side: (selectedColor==i) ? const BorderSide(width: 2.5, color: Colors.black54) : BorderSide.none), primary: colors[i],),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top:20,left:280.0),
            child: ElevatedButton(
              onPressed: () { ok(); },
              child: const Text(
                '설정',
                style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xffFF6280))),
            ),
          )
        ],
      ),);
  }
}

class Schedule{
  Schedule({
    required this.id,
    required this.startHour,
    required this.startMin,
    required this.endHour,
    required this.endMin,
    required this.title,
    required this.color,
    required this.day,
  });
  int id;
  final int startHour;
  final int startMin;
  final int endHour;
  final int endMin;
  final String title;
  final Color color;
  final String day;
}

class TimeTable extends StatefulWidget {
  TimeTable({
    required this.startEditTimeTable,
    required this.selectTimeTable,
  });

  final void Function() startEditTimeTable;
  final void Function(Schedule?) selectTimeTable;

  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {

  TableEvent convert(Schedule sc) {print('${sc.id}: ${sc.title}'); return TableEvent(
    start: TableEventTime(hour: sc.startHour, minute: sc.startMin),
    end: TableEventTime(hour: sc.endHour, minute: sc.endMin),
    title: sc.title,
    backgroundColor: sc.color,
    textStyle: const TextStyle(color: Colors.white),
    onTap: (){widget.selectTimeTable(sc); widget.startEditTimeTable();},
  );}

  Future<List<List<TableEvent>>> _loadSchedule() async{
    var db = DBHelper();
    List<String> list = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    List<List<TableEvent>> res = [];
    for(int i=0; i<list.length; i++){
      res.add((await db.schedules(list[i])).map((sc) => convert(sc)).toList());
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 10,),
      Center(
        child: Container(
          width: 350, height: 460,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1, color: Colors.black54,
            ),
          ),
          child: _setTable(),
        ),
      ),
      const SizedBox(height: 10,),
      Padding(padding: const EdgeInsets.only(left: 250.0),
        child: Container(height: 35, decoration: const BoxDecoration(color: Color(0xFFFF6082), borderRadius: BorderRadius.all(Radius.circular(12.0),),),
          child: TextButton(onPressed: (){widget.selectTimeTable(null); widget.startEditTimeTable();}, // move to addTimeTablePage
            child: const Text('추가', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12,),),),
        ),
      ),
    ],
    );
  }

  Widget _setTable(){
    return FutureBuilder(
      future: _loadSchedule(),
      builder: (context, snapshot){
        if(snapshot.hasData == false) return Column(children: const [SizedBox(height: 10), CircularProgressIndicator(strokeWidth: 2.0,), SizedBox(height: 10)],);
        if(snapshot.hasError) return Padding(padding: const EdgeInsets.all(8.0), child: Text('Error: ${snapshot.error}', style: const TextStyle(fontSize: 15),),);

        List<List<TableEvent>> data = snapshot.data as List<List<TableEvent>>;
        return TimetableView(
          laneEventsList:[
            LaneEvents(
              lane: Lane(name: '일', width: 42, height: 30, textStyle: const TextStyle(color: Color(0xFFFF6082))),
              events: data[0],
            ),
            LaneEvents(
              lane: Lane(name: '월', width: 42, height: 30, textStyle: const TextStyle(color: Color(0xFFFF6082))),
              events: data[1],
            ),
            LaneEvents(
              lane: Lane(name: '화', width: 42, height: 30, textStyle: const TextStyle(color: Color(0xFFFF6082))),
              events: data[2],
            ),
            LaneEvents(
              lane: Lane(name: '수', width: 42, height: 30, textStyle: const TextStyle(color: Color(0xFFFF6082))),
              events: data[3],
            ),
            LaneEvents(
              lane: Lane(name: '목', width: 42, height: 30, textStyle: const TextStyle(color: Color(0xFFFF6082))),
              events: data[4],
            ),
            LaneEvents(
              lane: Lane(name: '금', width: 42, height: 30, textStyle: const TextStyle(color: Color(0xFFFF6082))),
              events: data[5],
            ),
            LaneEvents(
              lane: Lane(name: '토', width: 42, height: 30, textStyle: const TextStyle(color: Color(0xFFFF6082))),
              events: data[6],
            ),
          ],
          timetableStyle: const TimetableStyle(timeItemHeight: 50, timeItemWidth: 40, laneWidth: 42, timeItemTextColor: Color(0xFFFF6082)),
        );
      },
    );
  }
}