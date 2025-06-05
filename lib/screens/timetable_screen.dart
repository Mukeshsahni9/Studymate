import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/timetable/timetable_bloc.dart';
import '../blocs/timetable/timetable_event.dart';
import '../blocs/timetable/timetable_state.dart';
import '../models/timetable.dart';
import '../utils/app_theme.dart' as theme;

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timetable'),
      ),
      body: BlocBuilder<TimetableBloc, TimetableState>(
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

          return DefaultTabController(
            length: 7,
            child: Column(
              children: [
                const TabBar(
                  isScrollable: true,
                  tabs: [
                    Tab(text: 'Monday'),
                    Tab(text: 'Tuesday'),
                    Tab(text: 'Wednesday'),
                    Tab(text: 'Thursday'),
                    Tab(text: 'Friday'),
                    Tab(text: 'Saturday'),
                    Tab(text: 'Sunday'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: List.generate(7, (index) {
                      final dayTimetables = state.getTimetablesForDay(index);
                      if (dayTimetables.isEmpty) {
                        return Center(
                          child: Text(
                            'No classes scheduled',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: dayTimetables.length,
                        itemBuilder: (context, i) {
                          final timetable = dayTimetables[i];
                          return _buildClassCard(context, timetable);
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddClassDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildClassCard(BuildContext context, Timetable timetable) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        timetable.subject,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        timetable.taskType,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    context.read<TimetableBloc>().add(DeleteTimetable(timetable.id));
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Teacher: ${timetable.teacher}'),
            Text('Room: ${timetable.room}'),
            Text(
              'Time: ${_formatTimeOfDay(timetable.startTime)} - ${_formatTimeOfDay(timetable.endTime)}',
            ),
            Text(
              'Days: ${_formatDays(timetable.days)}',
            ),
          ],
        ),
      ),
    );
  }

  void _showAddClassDialog(BuildContext context) {
    final subjectController = TextEditingController();
    final teacherController = TextEditingController();
    final roomController = TextEditingController();
    final taskTypeController = TextEditingController();
    TimeOfDay? startTime;
    TimeOfDay? endTime;
    final selectedDays = <int>[];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Class'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: subjectController,
                  decoration: const InputDecoration(labelText: 'Subject'),
                ),
                TextField(
                  controller: teacherController,
                  decoration: const InputDecoration(labelText: 'Teacher'),
                ),
                TextField(
                  controller: roomController,
                  decoration: const InputDecoration(labelText: 'Room'),
                ),
                TextField(
                  controller: taskTypeController,
                  decoration: const InputDecoration(
                    labelText: 'Task Type',
                    hintText: 'e.g., Lecture, Lab, Assignment, Quiz',
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Start Time'),
                  subtitle: Text(startTime != null
                      ? '${startTime!.hour}:${startTime!.minute.toString().padLeft(2, '0')}'
                      : 'Select time'),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() => startTime = time);
                    }
                  },
                ),
                ListTile(
                  title: const Text('End Time'),
                  subtitle: Text(endTime != null
                      ? '${endTime!.hour}:${endTime!.minute.toString().padLeft(2, '0')}'
                      : 'Select time'),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() => endTime = time);
                    }
                  },
                ),
                const SizedBox(height: 16),
                const Text('Select Days:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: List.generate(7, (index) {
                    final day = index;
                    return FilterChip(
                      label: Text(_getDayName(day)),
                      selected: selectedDays.contains(day),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedDays.add(day);
                          } else {
                            selectedDays.remove(day);
                          }
                        });
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (subjectController.text.isEmpty ||
                    teacherController.text.isEmpty ||
                    roomController.text.isEmpty ||
                    taskTypeController.text.isEmpty ||
                    startTime == null ||
                    endTime == null ||
                    selectedDays.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields'),
                    ),
                  );
                  return;
                }
                context.read<TimetableBloc>().add(
                      AddTimetable(
                        subject: subjectController.text,
                        teacher: teacherController.text,
                        room: roomController.text,
                        taskType: taskTypeController.text,
                        startTime: startTime!,
                        endTime: endTime!,
                        days: selectedDays,
                      ),
                    );
                Navigator.pop(context);
              },
              child: const Text('Add'),
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

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _formatDays(List<int> days) {
    return days.map((day) => _getDayName(day)).join(', ');
  }

  String _getDayName(int day) {
    switch (day) {
      case 0:
        return 'Monday';
      case 1:
        return 'Tuesday';
      case 2:
        return 'Wednesday';
      case 3:
        return 'Thursday';
      case 4:
        return 'Friday';
      case 5:
        return 'Saturday';
      case 6:
        return 'Sunday';
      default:
        return '';
    }
  }
} 