import 'package:flutter/material.dart';
import 'package:part_time_community/NoticeWriting.dart';

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
          BottomBarIcon(icon: Icons.home_outlined, isSelected: home_selected,),
          BottomBarIcon(icon: Icons.palette_outlined, isSelected: timeTable_selected,),
          const SizedBox(),
          BottomBarIcon(icon: Icons.message_outlined, isSelected: message_selected,),
          BottomBarIcon(icon: Icons.account_circle_outlined, isSelected: personal_selected,),
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
      padding: const EdgeInsets.symmetric(vertical: 10),
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

      child: const Icon(Icons.add,size: 30,),
      onPressed: () {},
      backgroundColor: const Color(0xFFFF6281),
    );
  }
}
