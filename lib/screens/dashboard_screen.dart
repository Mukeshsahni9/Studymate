import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/exams/exams_bloc.dart';
import '../blocs/exams/exams_event.dart';
import '../blocs/exams/exams_state.dart';
import '../blocs/timetable/timetable_bloc.dart';
import '../blocs/timetable/timetable_state.dart';
import '../models/exam.dart';
import '../models/timetable.dart';
import '../utils/app_theme.dart';
import 'timetable_screen.dart';
import 'pomodoro_screen.dart';
import 'exams_screen.dart';
import 'progress_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const _DashboardContent(),
    const TimetableScreen(),
    const PomodoroScreen(),
    const ExamsScreen(),
    const ProgressScreen(),
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
            icon: Icon(Icons.schedule),
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
            icon: Icon(Icons.trending_up),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              'Today\'s Schedule',
              BlocBuilder<TimetableBloc, TimetableState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.error != null) {
                    return Center(
                      child: Text(
                        'Error: ${state.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final today = DateTime.now().weekday - 1; // Convert to 0-based index
                  final todayTimetables = state.getTimetablesForDay(today);

                  if (todayTimetables.isEmpty) {
                    return _buildEmptyState('No classes scheduled for today');
                  }

                  return Column(
                    children: todayTimetables.map((timetable) {
                      return _buildScheduleCard(context, timetable);
                    }).toList(),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              'Upcoming Exams',
              BlocBuilder<ExamsBloc, ExamsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.error != null) {
                    return Center(
                      child: Text(
                        'Error: ${state.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  final upcomingExams = state.upcomingExams;

                  if (upcomingExams.isEmpty) {
                    return _buildEmptyState('No upcoming exams');
                  }

                  return Column(
                    children: upcomingExams.take(3).map((exam) {
                      return _buildExamCard(context, exam);
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        content,
      ],
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleCard(BuildContext context, Timetable timetable) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              _getSubjectIcon(timetable.subject),
              color: AppTheme.primaryColor,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timetable.subject,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${_formatTime(timetable.startTime)} - ${_formatTime(timetable.endTime)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Room ${timetable.room}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExamCard(BuildContext context, Exam exam) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getSubjectIcon(exam.subject),
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exam.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        exam.subject,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  '${exam.date.day}/${exam.date.month}/${exam.date.year}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  '${exam.date.hour.toString().padLeft(2, '0')}:${exam.date.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getSubjectIcon(String subject) {
    switch (subject.toLowerCase()) {
      case 'mathematics':
        return Icons.calculate;
      case 'physics':
        return Icons.science;
      case 'chemistry':
        return Icons.science;
      case 'biology':
        return Icons.biotech;
      case 'english':
        return Icons.menu_book;
      case 'history':
        return Icons.history_edu;
      case 'geography':
        return Icons.public;
      default:
        return Icons.school;
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
} 