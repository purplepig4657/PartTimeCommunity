import 'package:flutter/material.dart';
import '../app.dart';

class ReadContent extends StatefulWidget {
  ReadContent({Key? key,
    required this.selectContent}) : super(key: key);

  BoardContent selectContent;

  @override
  _ReadContentState createState() => _ReadContentState();
}

class _ReadContentState extends State<ReadContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 520,
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                  elevation: 0.0,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.selectContent.name,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.selectContent.title,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.selectContent.content,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  )),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1.3,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Card(
                color: Colors.transparent,
                elevation: 0.0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '댓글 쓴 애',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon:
                                const Icon(Icons.chat_bubble_outline_outlined)),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_vert)),
                          ],
                        ),
                      ],
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          '댓글댓글댓글댓글댓글',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
