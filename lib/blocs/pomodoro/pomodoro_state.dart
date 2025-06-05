import 'package:equatable/equatable.dart';

class PomodoroState extends Equatable {
  final int timeLeft;
  final int pomodorosCompleted;
  final bool isRunning;
  final bool isWorkTime;
  final int workDuration;
  final int shortBreakDuration;
  final int longBreakDuration;
  final int pomodorosUntilLongBreak;
  final String? error;

  const PomodoroState({
    required this.timeLeft,
    required this.pomodorosCompleted,
    required this.isRunning,
    required this.isWorkTime,
    required this.workDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.pomodorosUntilLongBreak,
    this.error,
  });

  factory PomodoroState.initial() {
    return const PomodoroState(
      timeLeft: 25 * 60, // 25 minutes in seconds
      pomodorosCompleted: 0,
      isRunning: false,
      isWorkTime: true,
      workDuration: 25,
      shortBreakDuration: 5,
      longBreakDuration: 15,
      pomodorosUntilLongBreak: 4,
    );
  }

  PomodoroState copyWith({
    int? timeLeft,
    int? pomodorosCompleted,
    bool? isRunning,
    bool? isWorkTime,
    int? workDuration,
    int? shortBreakDuration,
    int? longBreakDuration,
    int? pomodorosUntilLongBreak,
    String? error,
  }) {
    return PomodoroState(
      timeLeft: timeLeft ?? this.timeLeft,
      pomodorosCompleted: pomodorosCompleted ?? this.pomodorosCompleted,
      isRunning: isRunning ?? this.isRunning,
      isWorkTime: isWorkTime ?? this.isWorkTime,
      workDuration: workDuration ?? this.workDuration,
      shortBreakDuration: shortBreakDuration ?? this.shortBreakDuration,
      longBreakDuration: longBreakDuration ?? this.longBreakDuration,
      pomodorosUntilLongBreak: pomodorosUntilLongBreak ?? this.pomodorosUntilLongBreak,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        timeLeft,
        pomodorosCompleted,
        isRunning,
        isWorkTime,
        workDuration,
        shortBreakDuration,
        longBreakDuration,
        pomodorosUntilLongBreak,
        error,
      ];
} 