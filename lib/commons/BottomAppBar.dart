import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final home_selected, message_selected, timeTable_selected, personal_selected;
  const BottomBar({Key? key,
                   this.home_selected = false, this.message_selected = false,
                   this.timeTable_selected = false, this.personal_selected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomBarIcon(icon: Icons.home, isSelected: home_selected,),
          BottomBarIcon(icon: Icons.message, isSelected: message_selected,),
          const SizedBox(),
          BottomBarIcon(icon: Icons.alarm, isSelected: timeTable_selected,),
          BottomBarIcon(icon: Icons.person, isSelected: personal_selected,),
        ],
      ),
    );
  }
}

class BottomBarIcon extends StatelessWidget {
  final IconData icon;
  final isSelected;
  const BottomBarIcon({Key? key, this.icon = Icons.home, this.isSelected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: IconButton(
        icon: isSelected ? Icon(icon, color: const Color(0xFFFF6281),) : Icon(icon),
        onPressed: () {},
        iconSize: 30,
      ),
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
