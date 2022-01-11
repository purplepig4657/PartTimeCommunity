import 'package:flutter/material.dart';

import 'commons/BottomAppBar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      /** AppBar **/
      bottomNavigationBar: BottomBar(home_selected: true,),
      floatingActionButton: FloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      /** AppBar **/

    );
  }
}
