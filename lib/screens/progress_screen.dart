import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/progress/progress_bloc.dart';
import '../models/progress.dart';
import '../utils/app_theme.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: BlocBuilder<ProgressBloc, ProgressState>(
        builder: (context, state) {
          if (state is ProgressLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProgressError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is ProgressLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatsCard(context, state.progress),
                  const SizedBox(height: 16),
                  _buildAchievementsCard(context, state.progress),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context, Progress progress) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Study Stats',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildStatRow(
              context,
              'Completed Pomodoros',
              progress.completedPomodoros.toString(),
              Icons.timer,
            ),
            _buildStatRow(
              context,
              'Completed Assignments',
              progress.completedAssignments.toString(),
              Icons.assignment,
            ),
            _buildStatRow(
              context,
              'Completed Exams',
              progress.completedExams.toString(),
              Icons.school,
            ),
            _buildStatRow(
              context,
              'Study Streak',
              '${progress.studyStreak} days',
              Icons.local_fire_department,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryColor),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsCard(BuildContext context, Progress progress) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Achievements',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (progress.achievements.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Complete tasks to earn achievements!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: progress.achievements.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(
                      Icons.emoji_events,
                      color: Colors.amber,
                    ),
                    title: Text(progress.achievements[index]),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
} 