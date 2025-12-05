import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/view/home_screen.dart';
import '../../notes/view/note_screen.dart';
import '../../routine/view/routine_screen.dart';
import '../../tools/view/tools_screen.dart';
import '../viewmodel/bottom_nav_bar_viewmodel.dart';

class BottomNavBarScreen extends ConsumerStatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  ConsumerState<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends ConsumerState<BottomNavBarScreen> {
  // Screen list with separate screen widgets
  final List<Widget> _screenList = [
    HomeScreen(),
    RoutineScreen(),
    NoteScreen(),
    ToolsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenList[ref.watch(bottomNavBarProvider)],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: ref.watch(bottomNavBarProvider),
        onTap: (index) {
          ref.read(bottomNavBarProvider.notifier).onItemTapped(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Routine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Note',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Tools',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}