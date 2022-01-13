import 'package:flutter/material.dart';
import '../app.dart';

class FreeBoard extends StatefulWidget {
  FreeBoard({Key? key,
    required this.freeBoardContent,
    required this.startWriteContent,
    required this.startReadContent,
    required this.selectContent}) : super(key: key);

  List<BoardContent> freeBoardContent;
  final void Function() startWriteContent;
  final void Function() startReadContent;
  final void Function(BoardContent) selectContent;

  @override
  _FreeBoardState createState() => _FreeBoardState();
}

class _FreeBoardState extends State<FreeBoard> {
  List<BoardContent> list = [];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      Center(
        child: SizedBox(
          width: 370,
          height: 460,
          child: Column(
            children: <Widget>[
              Expanded(
                //flex: 9,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                      border: Border.all(
                        width: 1,
                        color: Colors.black54,
                      )),
                  child: _buildBoard(),
                ),
              ),
              //Expanded(child: SizedBox(), flex: 1,)
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left:250.0),
        child: responsive("글 작성"),
      ),
    ]
    );
  }

  Widget _buildBoard() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      itemCount: widget.freeBoardContent.length * 2,
      itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();
        return _buildRow(i ~/ 2);
      },
    );
  }

  Widget _buildRow(int i) {
    list = widget.freeBoardContent;
    return ListTile(
      title: Text(list[i].title),
      trailing: const Icon(Icons.menu),
      onTap: () {
        widget.selectContent(list[i]);
        widget.startReadContent();
      },
    );
  }

  Widget responsive(String s) {
    return Container(
      height: 35,
      decoration: const BoxDecoration(
        color: Color(0xffFF6082),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: TextButton(
        onPressed: () {
          widget.startWriteContent();
        },
        child: Flexible(
          fit: FlexFit.loose,
          child: Text(
            s,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
