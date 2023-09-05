import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor: const Color(0xff2398C3),
      currentIndex: 0,
      onTap: (int) {},
      items: const [
        BottomNavigationBarItem(
          label: 'Index',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Calendar',
          icon: Icon(Icons.calendar_month_sharp),
        ),
        BottomNavigationBarItem(
          label: 'Focus',
          icon: Icon(Icons.watch_later_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(Icons.person_2_outlined),
        ),
      ],
    );
  }
}
