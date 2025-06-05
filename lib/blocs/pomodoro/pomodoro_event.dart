import 'package:equatable/equatable.dart';

abstract class PomodoroEvent extends Equatable {
  const PomodoroEvent();

  @override
  List<Object?> get props => [];
}

class LoadPomodoroSettings extends PomodoroEvent {
  const LoadPomodoroSettings();
}

class StartPomodoroTimer extends PomodoroEvent {
  const StartPomodoroTimer();
}

class PausePomodoroTimer extends PomodoroEvent {
  const PausePomodoroTimer();
}

class ResetPomodoroTimer extends PomodoroEvent {
  const ResetPomodoroTimer();
}

class SkipPomodoroTimer extends PomodoroEvent {
  const SkipPomodoroTimer();
}

class TimerTick extends PomodoroEvent {
  const TimerTick();
}

class UpdatePomodoroSettings extends PomodoroEvent {
  final int workDuration;
  final int shortBreakDuration;
  final int longBreakDuration;
  final int pomodorosUntilLongBreak;

  const UpdatePomodoroSettings({
    required this.workDuration,
    required this.shortBreakDuration,
    required this.longBreakDuration,
    required this.pomodorosUntilLongBreak,
  });

  @override
  List<Object?> get props => [
        workDuration,
        shortBreakDuration,
        longBreakDuration,
        pomodorosUntilLongBreak,
      ];
}

class CompletePomodoro extends PomodoroEvent {
  const CompletePomodoro();
} 