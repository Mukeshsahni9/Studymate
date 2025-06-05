import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/sound_utils.dart';
import 'pomodoro_event.dart';
import 'pomodoro_state.dart';
import '../progress/progress_bloc.dart';
import '../progress/progress_event.dart';
import '../../models/progress.dart';

class PomodoroBloc extends Bloc<PomodoroEvent, PomodoroState> {
  final SharedPreferences prefs;
  Timer? _timer;
  final ProgressBloc progressBloc;

  PomodoroBloc(this.prefs, {required this.progressBloc}) : super(PomodoroState.initial()) {
    on<LoadPomodoroSettings>(_onLoadSettings);
    on<StartPomodoroTimer>(_onStartTimer);
    on<PausePomodoroTimer>(_onPauseTimer);
    on<ResetPomodoroTimer>(_onResetTimer);
    on<SkipPomodoroTimer>(_onSkipTimer);
    on<UpdatePomodoroSettings>(_onUpdateSettings);
    on<TimerTick>(_onTimerTick);
    on<CompletePomodoro>(_onCompletePomodoro);
  }

  void _onLoadSettings(LoadPomodoroSettings event, Emitter<PomodoroState> emit) {
    final workDuration = prefs.getInt('workDuration') ?? 25;
    final shortBreakDuration = prefs.getInt('shortBreakDuration') ?? 5;
    final longBreakDuration = prefs.getInt('longBreakDuration') ?? 15;
    final pomodorosUntilLongBreak = prefs.getInt('pomodorosUntilLongBreak') ?? 4;

    emit(state.copyWith(
      workDuration: workDuration,
      shortBreakDuration: shortBreakDuration,
      longBreakDuration: longBreakDuration,
      pomodorosUntilLongBreak: pomodorosUntilLongBreak,
      timeLeft: state.isWorkTime ? workDuration * 60 : shortBreakDuration * 60,
    ));
  }

  void _onStartTimer(StartPomodoroTimer event, Emitter<PomodoroState> emit) {
    if (state.isRunning) {
      _timer?.cancel();
      emit(state.copyWith(isRunning: false));
    } else {
      _timer?.cancel();
      emit(state.copyWith(isRunning: true));
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        add(const TimerTick());
      });
    }
  }

  void _onTimerTick(TimerTick event, Emitter<PomodoroState> emit) async {
    if (state.timeLeft > 0) {
      emit(state.copyWith(timeLeft: state.timeLeft - 1));
    } else {
      _timer?.cancel();
      await SoundUtils.playTimerCompleteSound();
      if (state.isWorkTime) {
        final newPomodorosCompleted = state.pomodorosCompleted + 1;
        final isLongBreak = newPomodorosCompleted % state.pomodorosUntilLongBreak == 0;
        emit(state.copyWith(
          isRunning: false,
          isWorkTime: false,
          pomodorosCompleted: newPomodorosCompleted,
          timeLeft: isLongBreak
              ? state.longBreakDuration * 60
              : state.shortBreakDuration * 60,
        ));
      } else {
        emit(state.copyWith(
          isRunning: false,
          isWorkTime: true,
          timeLeft: state.workDuration * 60,
        ));
      }
    }
  }

  void _onPauseTimer(PausePomodoroTimer event, Emitter<PomodoroState> emit) {
    _timer?.cancel();
    emit(state.copyWith(isRunning: false));
  }

  void _onResetTimer(ResetPomodoroTimer event, Emitter<PomodoroState> emit) {
    _timer?.cancel();
    emit(state.copyWith(
      timeLeft: state.workDuration * 60,
      isRunning: false,
      isWorkTime: true,
      pomodorosCompleted: 0,
    ));
  }

  void _onSkipTimer(SkipPomodoroTimer event, Emitter<PomodoroState> emit) {
    _timer?.cancel();
    if (state.isWorkTime) {
      final newPomodorosCompleted = state.pomodorosCompleted + 1;
      final isLongBreak = newPomodorosCompleted % state.pomodorosUntilLongBreak == 0;
      emit(state.copyWith(
        isRunning: false,
        isWorkTime: false,
        pomodorosCompleted: newPomodorosCompleted,
        timeLeft: isLongBreak
            ? state.longBreakDuration * 60
            : state.shortBreakDuration * 60,
      ));
    } else {
      emit(state.copyWith(
        isRunning: false,
        isWorkTime: true,
        timeLeft: state.workDuration * 60,
      ));
    }
  }

  void _onUpdateSettings(
    UpdatePomodoroSettings event,
    Emitter<PomodoroState> emit,
  ) {
    prefs.setInt('workDuration', event.workDuration);
    prefs.setInt('shortBreakDuration', event.shortBreakDuration);
    prefs.setInt('longBreakDuration', event.longBreakDuration);
    prefs.setInt('pomodorosUntilLongBreak', event.pomodorosUntilLongBreak);

    emit(state.copyWith(
      workDuration: event.workDuration,
      shortBreakDuration: event.shortBreakDuration,
      longBreakDuration: event.longBreakDuration,
      pomodorosUntilLongBreak: event.pomodorosUntilLongBreak,
      timeLeft: state.isWorkTime
          ? event.workDuration * 60
          : (state.pomodorosCompleted % event.pomodorosUntilLongBreak == 0
              ? event.longBreakDuration * 60
              : event.shortBreakDuration * 60),
    ));
  }

  void _onCompletePomodoro(
    CompletePomodoro event,
    Emitter<PomodoroState> emit,
  ) {
    final updatedState = state.copyWith(
      isRunning: false,
      pomodorosCompleted: state.pomodorosCompleted + 1,
    );
    emit(updatedState);

    // Update progress
    progressBloc.add(
      UpdateProgress(
        Progress(
          completedPomodoros: updatedState.pomodorosCompleted,
          studyStreak: 1,
        ),
      ),
    );

    // Check for achievements
    if (updatedState.pomodorosCompleted == 1) {
      progressBloc.add(
        const AddAchievement('First Pomodoro! 🎉'),
      );
    } else if (updatedState.pomodorosCompleted == 5) {
      progressBloc.add(
        const AddAchievement('Pomodoro Master! 🌟'),
      );
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    SoundUtils.dispose();
    return super.close();
  }
} 