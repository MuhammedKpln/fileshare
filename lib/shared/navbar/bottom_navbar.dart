import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar(
      {super.key, required this.currentIndex, required this.onTap,});

  final int currentIndex;

  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.verified_user), label: 'Login')
      ],
      onTap: onTap,
      currentIndex: currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
