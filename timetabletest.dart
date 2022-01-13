import 'package:flutter/material.dart';
import 'TimeTable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DBHelper().initDB(); // required
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const myHomePage(),
    );
  }
}


class myHomePage extends StatefulWidget {
  const myHomePage({Key? key}) : super(key: key);

  @override
  _myHomePageState createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> [

  Schedule? selectedTimeTable;
  void startEditTimeTable(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => secondPage(selectedTimeTable)),
    );
    //EditTimeContent(selectedTimeTable);
  }
  void selectTimeTable(Schedule? sc){
    selectedTimeTable = sc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Timetable View Demo'),
          actions: [IconButton(onPressed: (){setState((){});}, icon: Icon(Icons.menu))],
        ),
        body: TimeTable(
          startEditTimeTable: startEditTimeTable,
          selectTimeTable: selectTimeTable,
        )
    );
  }
}


class secondPage extends StatefulWidget {
  secondPage(this.schedule);
  final Schedule? schedule;

  @override
  _secondPageState createState() => _secondPageState();
}

class _secondPageState extends State<secondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Timetable View Demo'),
        ),
        body: EditTimeContent(widget.schedule),
    );
  }
}
