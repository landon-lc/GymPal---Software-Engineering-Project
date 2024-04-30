import 'package:flutter/material.dart';
import './map_screen.dart';
import './profile_screen.dart';
import './friends_screen.dart';
import './checklist_screen.dart';

class PageNavigation extends StatefulWidget {
  const PageNavigation({super.key});

  @override
  State<PageNavigation> createState() => _PageNavigation();
}

class _PageNavigation extends State<PageNavigation> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const UserProfileScreen(),
    const ChecklistPage(),
    const FriendsListScreen(),
    const GymMaps(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GymPal'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xfffffff4),
        selectedItemColor: const Color(0xff3ea9a9),
        unselectedItemColor: const Color(0xff2f2f2f),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Map'),
        ],
      ),
    );
  }
}
