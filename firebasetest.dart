import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterfirebase/firebase_options.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  ChangeNotifierProvider(
    builder: (context, _) => MyApp(),
    create: (context) => BoardState(),
  )
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'myapp',
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<BoardState>(
          builder: (content, board, _) => Board(
            addBoard: (bc) => board.addboard(BoardContent(title: bc.title, done: bc.done)),
            boards: board.boardContents,
          ),
        ),
      )
    );
  }
}


class BoardState extends ChangeNotifier{
  List<BoardContent> _boardContent = [BoardContent(title: '으악', done: true)];
  List<BoardContent> get boardContents => _boardContent;
  BoardState() { init(); }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseFirestore.instance
    .collection('board')
    .orderBy('timestamp', descending: true)
    .snapshots()
    .listen((snapshot){
      _boardContent=[];
      for(final doc in snapshot.docs){
        _boardContent.add(
          BoardContent(
            title: doc.data()['title'] as String,
            done: doc.data()['done'] as bool,
          ),
        );
      }
      notifyListeners();
    });
  }

  Future<DocumentReference> addboard(BoardContent boardContent){
    return FirebaseFirestore.instance
        .collection('board')
        .add(<String, dynamic>{
      'title': boardContent.title,
      'done': boardContent.done,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    });
  }

}

class BoardContent{
  String title;
  bool done;
  BoardContent({required this.title, required this.done});
}

class Board extends StatefulWidget {
  Board({required this.addBoard, required this.boards});
  final Future<void> Function(BoardContent content) addBoard;
  final List<BoardContent> boards;

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_BoardState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Form(key: _formKey, child: Row(
        children: <Widget>[
          Expanded(child: TextFormField(controller: _controller, decoration: const InputDecoration(hintText: 'Message'),
            validator: (value){
              if(value==null || value.isEmpty) return 'Enter your Message';
              return null;
            }
            ,),),
          ElevatedButton(
              onPressed: () async {
                if(_formKey.currentState!.validate()){
                  await widget.addBoard(BoardContent(title: _controller.text, done: false));
                  _controller.clear();
                }
              },
              child: Text('추가')),
          ]
        ),),
        ListView(
          children: widget.boards.map((bc) => ListTile(
            onTap: (){print(bc.title);},
            title: Text(bc.title,
              style: TextStyle(color: bc.done ? Colors.grey : Colors.black),),
            trailing: Icon(Icons.menu),
          )).toList(),
        ),
      ],
    );
  }
}
