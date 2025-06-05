import 'package:flutter/material.dart';
import 'pomodoro_screen.dart';
import 'timetable_screen.dart';
import 'exams_screen.dart';
import 'progress_screen.dart';
import 'settings_screen.dart';
import '../utils/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const PomodoroScreen(),
    const TimetableScreen(),
    const ExamsScreen(),
    const ProgressScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.timer),
            label: 'Pomodoro',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today),
            label: 'Timetable',
          ),
          NavigationDestination(
            icon: Icon(Icons.school),
            label: 'Exams',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
} 