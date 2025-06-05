import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class ToggleDarkMode extends SettingsEvent {
  final bool isDarkMode;

  const ToggleDarkMode(this.isDarkMode);

  @override
  List<Object?> get props => [isDarkMode];
}

class ToggleNotifications extends SettingsEvent {
  final bool enabled;

  const ToggleNotifications(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class ToggleSound extends SettingsEvent {
  final bool enabled;

  const ToggleSound(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class ChangeLanguage extends SettingsEvent {
  final String language;

  const ChangeLanguage(this.language);

  @override
  List<Object?> get props => [language];
}

class UpdatePomodoroSettings extends SettingsEvent {
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

class ResetSettings extends SettingsEvent {} 