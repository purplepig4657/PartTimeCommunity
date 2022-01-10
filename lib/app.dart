import 'package:flutter/material.dart';

import 'home.dart';

class PartTimeCommunity extends StatelessWidget {
  const PartTimeCommunity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'PartTime Community',
      home: Home(),
    );
  }
}

