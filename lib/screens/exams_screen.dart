import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/app_theme.dart';
import '../blocs/exams/exams_bloc.dart';
import '../blocs/exams/exams_event.dart';
import '../blocs/exams/exams_state.dart';
import '../models/exam.dart';

class ExamsScreen extends StatelessWidget {
  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exams',
          style: AppTheme.titleLarge.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ExamsBloc, ExamsState>(
        builder: (context, state) {
          final now = DateTime.now();
          final upcomingExams = state.exams
              .where((exam) => exam.date.isAfter(now))
              .toList()
            ..sort((a, b) => a.date.compareTo(b.date));

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  'Upcoming Exams',
                  upcomingExams.isEmpty
                      ? [
                          _buildEmptyState(
                            'No upcoming exams',
                            Icons.assignment,
                          ),
                        ]
                      : upcomingExams.map((exam) => _buildExamCard(context, exam)).toList(),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddExamDialog(context),
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              icon,
              size: 48,
              color: AppTheme.primaryColor.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: AppTheme.bodyLarge.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    exam.title,
                    style: AppTheme.titleMedium,
                  ),
                ),
                Icon(
                  _getSubjectIcon(exam.subject),
                  color: AppTheme.primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              exam.subject,
              style: AppTheme.bodyMedium.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text(
                  '${exam.date.day}/${exam.date.month}/${exam.date.year}',
                  style: AppTheme.bodyMedium,
                ),
                const SizedBox(width: 16),
                const Icon(Icons.access_time, size: 16),
                const SizedBox(width: 8),
                Text(
                  exam.time.format(context),
                  style: AppTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.timer, size: 16),
                const SizedBox(width: 8),
                Text(
                  exam.duration,
                  style: AppTheme.bodyMedium,
                ),
                const SizedBox(width: 16),
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 8),
                Text(
                  exam.location,
                  style: AppTheme.bodyMedium,
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
      case 'science':
        return Icons.science;
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

  void _showAddExamDialog(BuildContext context) {
    final titleController = TextEditingController();
    final subjectController = TextEditingController();
    final locationController = TextEditingController();
    final durationController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add Exam'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Exam Title',
                    hintText: 'Enter exam title',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: subjectController,
                  decoration: const InputDecoration(
                    labelText: 'Subject',
                    hintText: 'Enter subject',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    hintText: 'Enter exam location',
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: durationController,
                  decoration: const InputDecoration(
                    labelText: 'Duration',
                    hintText: 'Enter exam duration (e.g., 2 hours)',
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Exam Date'),
                  subtitle: Text(
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setState(() {
                        selectedDate = date;
                      });
                    }
                  },
                ),
                ListTile(
                  title: const Text('Exam Time'),
                  subtitle: Text(selectedTime.format(context)),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (time != null) {
                      setState(() {
                        selectedTime = time;
                      });
                    }
                  },
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
                if (titleController.text.isEmpty ||
                    subjectController.text.isEmpty ||
                    locationController.text.isEmpty ||
                    durationController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill in all fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Combine date and time
                final examDateTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );

                // Check if the exam date is in the past
                if (examDateTime.isBefore(DateTime.now())) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Exam date and time must be in the future'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                context.read<ExamsBloc>().add(
                      AddExam(
                        title: titleController.text,
                        subject: subjectController.text,
                        location: locationController.text,
                        duration: durationController.text,
                        date: examDateTime,
                        time: selectedTime,
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
} 