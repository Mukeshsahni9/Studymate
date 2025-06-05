import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SharedPreferences _prefs;

  SettingsBloc(this._prefs) : super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleDarkMode>(_onToggleDarkMode);
    on<ToggleNotifications>(_onToggleNotifications);
    on<ToggleSound>(_onToggleSound);
    on<ChangeLanguage>(_onChangeLanguage);
    on<UpdatePomodoroSettings>(_onUpdatePomodoroSettings);
  }

  Future<void> _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      
      final isDarkMode = _prefs.getBool('isDarkMode') ?? false;
      final notificationsEnabled = _prefs.getBool('notificationsEnabled') ?? true;
      final soundEnabled = _prefs.getBool('soundEnabled') ?? true;
      final language = _prefs.getString('language') ?? 'English';
      final workDuration = _prefs.getInt('workDuration') ?? 25;
      final shortBreakDuration = _prefs.getInt('shortBreakDuration') ?? 5;
      final longBreakDuration = _prefs.getInt('longBreakDuration') ?? 15;
      final pomodorosUntilLongBreak = _prefs.getInt('pomodorosUntilLongBreak') ?? 4;

      emit(state.copyWith(
        isLoading: false,
        isDarkMode: isDarkMode,
        notificationsEnabled: notificationsEnabled,
        soundEnabled: soundEnabled,
        language: language,
        workDuration: workDuration,
        shortBreakDuration: shortBreakDuration,
        longBreakDuration: longBreakDuration,
        pomodorosUntilLongBreak: pomodorosUntilLongBreak,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load settings: $e',
      ));
    }
  }

  Future<void> _onToggleDarkMode(ToggleDarkMode event, Emitter<SettingsState> emit) async {
    try {
      await _prefs.setBool('isDarkMode', event.isDarkMode);
      emit(state.copyWith(isDarkMode: event.isDarkMode));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to update dark mode: $e'));
    }
  }

  Future<void> _onToggleNotifications(ToggleNotifications event, Emitter<SettingsState> emit) async {
    try {
      await _prefs.setBool('notificationsEnabled', event.enabled);
      emit(state.copyWith(notificationsEnabled: event.enabled));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to update notifications: $e'));
    }
  }

  Future<void> _onToggleSound(ToggleSound event, Emitter<SettingsState> emit) async {
    try {
      await _prefs.setBool('soundEnabled', event.enabled);
      emit(state.copyWith(soundEnabled: event.enabled));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to update sound: $e'));
    }
  }

  Future<void> _onChangeLanguage(ChangeLanguage event, Emitter<SettingsState> emit) async {
    try {
      await _prefs.setString('language', event.language);
      emit(state.copyWith(language: event.language));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to update language: $e'));
    }
  }

  Future<void> _onUpdatePomodoroSettings(
    UpdatePomodoroSettings event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      await _prefs.setInt('workDuration', event.workDuration);
      await _prefs.setInt('shortBreakDuration', event.shortBreakDuration);
      await _prefs.setInt('longBreakDuration', event.longBreakDuration);
      await _prefs.setInt('pomodorosUntilLongBreak', event.pomodorosUntilLongBreak);

      emit(state.copyWith(
        workDuration: event.workDuration,
        shortBreakDuration: event.shortBreakDuration,
        longBreakDuration: event.longBreakDuration,
        pomodorosUntilLongBreak: event.pomodorosUntilLongBreak,
      ));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to update Pomodoro settings: $e'));
    }
  }
} 