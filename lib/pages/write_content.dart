import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WriteContent extends StatefulWidget {
  const WriteContent({Key? key,
    required this.startPrevious}) : super(key: key);

  final void Function() startPrevious;

  @override
  _WriteContentState createState() => _WriteContentState();
}

class _WriteContentState extends State<WriteContent> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_BodyContent');
  final _title_controller = TextEditingController();
  final _content_controller = TextEditingController();

  Future<DocumentReference> addContentToFreeBoard(String title, String content) {
    return FirebaseFirestore.instance
        .collection('freeboard')
        .add(<String, dynamic>{
      'title': title,
      'content': content,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Form(
          key: _formKey,
          child: Container(
            width: 350,
            height: 470,
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
                    title: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 15,
                      cursorColor: Color(0xffFF6280),
                      controller: _title_controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your message to continue';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffFF6280)),
                          ),
                          hintText: '제목을 입력하세요.'),
                    )),
                Divider(),
                ListTile(
                    title: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      maxLength: 1000,
                      cursorColor: Color(0xffFF6280),
                      controller: _content_controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your message to continue';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffFF6280)),
                          ),
                          hintText: '내용을 입력하세요.'),
                    )),
              ],
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.grey)),
              onPressed: () {

              },
              child: const Text('clear'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xffFF6280))),
              onPressed: () {
                addContentToFreeBoard(_title_controller.text, _content_controller.text);
                widget.startPrevious();
              },
              child: const Text('upload'),
            ),
          )
        ])
        
      ]),
    );
  }
}
