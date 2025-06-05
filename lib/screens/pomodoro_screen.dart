import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/theme.dart';
import '../blocs/pomodoro/pomodoro_bloc.dart';
import '../blocs/pomodoro/pomodoro_event.dart';
import '../blocs/pomodoro/pomodoro_state.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _showNotification(BuildContext context, bool isWorkTime) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          isWorkTime ? 'Break Time!' : 'Time to Work!',
          style: AppTheme.titleLarge,
        ),
        content: Text(
          isWorkTime
              ? 'Take a break and relax for a while.'
              : 'Break is over. Let\'s get back to work!',
          style: AppTheme.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'OK',
              style: AppTheme.bodyLarge.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context, PomodoroState state) {
    final workDurationController = TextEditingController(text: state.workDuration.toString());
    final shortBreakController = TextEditingController(text: state.shortBreakDuration.toString());
    final longBreakController = TextEditingController(text: state.longBreakDuration.toString());
    final pomodorosUntilLongBreakController = TextEditingController(text: state.pomodorosUntilLongBreak.toString());

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(
            'Pomodoro Settings',
            style: AppTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: workDurationController,
                  decoration: const InputDecoration(
                    labelText: 'Work Duration (minutes)',
                    hintText: 'e.g., 25',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {}); // Trigger rebuild to update validation
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: shortBreakController,
                  decoration: const InputDecoration(
                    labelText: 'Short Break Duration (minutes)',
                    hintText: 'e.g., 5',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {}); // Trigger rebuild to update validation
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: longBreakController,
                  decoration: const InputDecoration(
                    labelText: 'Long Break Duration (minutes)',
                    hintText: 'e.g., 15',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {}); // Trigger rebuild to update validation
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: pomodorosUntilLongBreakController,
                  decoration: const InputDecoration(
                    labelText: 'Pomodoros until Long Break',
                    hintText: 'e.g., 4',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {}); // Trigger rebuild to update validation
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: AppTheme.bodyLarge.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final workDuration = int.tryParse(workDurationController.text);
                final shortBreak = int.tryParse(shortBreakController.text);
                final longBreak = int.tryParse(longBreakController.text);
                final pomodorosUntilLongBreak = int.tryParse(pomodorosUntilLongBreakController.text);

                if (workDuration == null || workDuration <= 0 ||
                    shortBreak == null || shortBreak <= 0 ||
                    longBreak == null || longBreak <= 0 ||
                    pomodorosUntilLongBreak == null || pomodorosUntilLongBreak <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter valid positive numbers for all fields'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                context.read<PomodoroBloc>().add(
                      UpdatePomodoroSettings(
                        workDuration: workDuration,
                        shortBreakDuration: shortBreak,
                        longBreakDuration: longBreak,
                        pomodorosUntilLongBreak: pomodorosUntilLongBreak,
                      ),
                    );
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: AppTheme.bodyLarge.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pomodoro Timer',
          style: AppTheme.titleLarge.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PomodoroBloc, PomodoroState>(
        listener: (context, state) {
          if (!state.isRunning && state.timeLeft == 0) {
            _showNotification(context, state.isWorkTime);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.isWorkTime ? 'Work Time' : 'Break Time',
                          style: AppTheme.titleLarge.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _formatTime(state.timeLeft),
                          style: AppTheme.headlineLarge.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Pomodoros completed: ${state.pomodorosCompleted}',
                          style: AppTheme.bodyMedium.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<PomodoroBloc>().add(const ResetPomodoroTimer());
                      },
                      icon: const Icon(Icons.refresh),
                      iconSize: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 32),
                    FloatingActionButton.large(
                      onPressed: () {
                        context.read<PomodoroBloc>().add(
                              state.isRunning
                                  ? const PausePomodoroTimer()
                                  : const StartPomodoroTimer(),
                            );
                      },
                      child: Icon(
                        state.isRunning ? Icons.pause : Icons.play_arrow,
                      ),
                    ),
                    const SizedBox(width: 32),
                    IconButton(
                      onPressed: () {
                        context.read<PomodoroBloc>().add(const SkipPomodoroTimer());
                      },
                      icon: const Icon(Icons.skip_next),
                      iconSize: 32,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () => _showSettingsDialog(context, state),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Settings',
                                style: AppTheme.titleLarge,
                              ),
                              Icon(
                                Icons.settings,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Work Duration',
                                      style: AppTheme.bodyMedium,
                                    ),
                                    Text(
                                      '${state.workDuration} minutes',
                                      style: AppTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Short Break',
                                      style: AppTheme.bodyMedium,
                                    ),
                                    Text(
                                      '${state.shortBreakDuration} minutes',
                                      style: AppTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Long Break',
                                      style: AppTheme.bodyMedium,
                                    ),
                                    Text(
                                      '${state.longBreakDuration} minutes',
                                      style: AppTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pomodoros until Long Break',
                                      style: AppTheme.bodyMedium,
                                    ),
                                    Text(
                                      '${state.pomodorosUntilLongBreak}',
                                      style: AppTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
} 