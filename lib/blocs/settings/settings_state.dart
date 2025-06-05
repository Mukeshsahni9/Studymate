import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool isLoading;
  final String? error;
  final bool isDarkMode;
  final bool notificationsEnabled;
  final bool soundEnabled;
  final String language;
  final int workDuration;
  final int shortBreakDuration;
  final int longBreakDuration;
  final int pomodorosUntilLongBreak;

  const SettingsState({
    this.isLoading = false,
    this.error,
    this.isDarkMode = false,
    this.notificationsEnabled = true,
    this.soundEnabled = true,
    this.language = 'English',
    this.workDuration = 25,
    this.shortBreakDuration = 5,
    this.longBreakDuration = 15,
    this.pomodorosUntilLongBreak = 4,
  });

  SettingsState copyWith({
    bool? isLoading,
    String? error,
    bool? isDarkMode,
    bool? notificationsEnabled,
    bool? soundEnabled,
    String? language,
    int? workDuration,
    int? shortBreakDuration,
    int? longBreakDuration,
    int? pomodorosUntilLongBreak,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      language: language ?? this.language,
      workDuration: workDuration ?? this.workDuration,
      shortBreakDuration: shortBreakDuration ?? this.shortBreakDuration,
      longBreakDuration: longBreakDuration ?? this.longBreakDuration,
      pomodorosUntilLongBreak: pomodorosUntilLongBreak ?? this.pomodorosUntilLongBreak,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        isDarkMode,
        notificationsEnabled,
        soundEnabled,
        language,
        workDuration,
        shortBreakDuration,
        longBreakDuration,
        pomodorosUntilLongBreak,
      ];
} 