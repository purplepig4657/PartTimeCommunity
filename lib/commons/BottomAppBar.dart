import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const BottomBarIcon(icon: Icons.star),
          const BottomBarIcon(icon: Icons.star),
          const SizedBox(),
          const BottomBarIcon(icon: Icons.star),
          const BottomBarIcon(icon: Icons.star),
        ],
      ),
    );
  }
}

class BottomBarIcon extends StatelessWidget {
  const BottomBarIcon({IconData? icon, Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: IconButton(icon: const Icon(icon), onPressed: () {}, iconSize: 30,),
    );
  }
}


class FloatingButton extends StatelessWidget {
  const FloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {},
      backgroundColor: const Color(0xFFFF6281),
    );
  }
}
