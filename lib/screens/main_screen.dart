import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import 'dashboard_screen.dart';
import 'timetable_screen.dart';
import 'pomodoro_screen.dart';
import 'exams_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const TimetableScreen(),
    const PomodoroScreen(),
    const ExamsScreen(),
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
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today),
            label: 'Timetable',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer),
            label: 'Pomodoro',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment),
            label: 'Exams',
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