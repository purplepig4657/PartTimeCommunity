import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WriteReview extends StatefulWidget {
  const WriteReview({Key? key,
    required this.startPrevious}) : super(key: key);

  final void Function() startPrevious;

  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_ReviewContent');
  final _content_controller = TextEditingController();

  Future<DocumentReference> addContentToReview(String content) {
    return FirebaseFirestore.instance
        .collection('review')
        .add(<String, dynamic>{
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
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0, left: 270),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xffFF6280))),
            onPressed: () {
              addContentToReview(_content_controller.text);
              widget.startPrevious();
            },
            child: const Text(
              '업로드',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Form(
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
                  maxLength: 1000,
                  cursorColor: const Color(0xffFF6280),
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
                      hintText: '리뷰를 작성해주세요.\n악의적인 게시글에 대한 책임은\n'
                          '본인의 몫입니다.'),
                )),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
