import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import '../../models/progress.dart';
import 'progress_event.dart';

// State
abstract class ProgressState extends Equatable {
  const ProgressState();

  @override
  List<Object?> get props => [];
}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState {}

class ProgressLoaded extends ProgressState {
  final Progress progress;

  const ProgressLoaded(this.progress);

  @override
  List<Object?> get props => [progress];
}

class ProgressError extends ProgressState {
  final String message;

  const ProgressError(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final SharedPreferences prefs;
  static const String _progressKey = 'progress';

  ProgressBloc({required this.prefs}) : super(ProgressInitial()) {
    on<LoadProgress>(_onLoadProgress);
    on<UpdateProgress>(_onUpdateProgress);
    on<AddAchievement>(_onAddAchievement);
  }

  Future<void> _onLoadProgress(
    LoadProgress event,
    Emitter<ProgressState> emit,
  ) async {
    try {
      emit(ProgressLoading());
      final progressJson = prefs.getString(_progressKey);
      if (progressJson != null) {
        final progress = Progress.fromJson(json.decode(progressJson));
        emit(ProgressLoaded(progress));
      } else {
        emit(const ProgressLoaded(Progress()));
      }
    } catch (e) {
      emit(ProgressError(e.toString()));
    }
  }

  Future<void> _onUpdateProgress(
    UpdateProgress event,
    Emitter<ProgressState> emit,
  ) async {
    try {
      await prefs.setString(_progressKey, json.encode(event.progress.toJson()));
      emit(ProgressLoaded(event.progress));
    } catch (e) {
      emit(ProgressError(e.toString()));
    }
  }

  Future<void> _onAddAchievement(
    AddAchievement event,
    Emitter<ProgressState> emit,
  ) async {
    try {
      if (state is ProgressLoaded) {
        final currentState = state as ProgressLoaded;
        final updatedAchievements = List<String>.from(currentState.progress.achievements)
          ..add(event.achievement);
        final updatedProgress = currentState.progress.copyWith(
          achievements: updatedAchievements,
        );
        await _onUpdateProgress(UpdateProgress(updatedProgress), emit);
      }
    } catch (e) {
      emit(ProgressError(e.toString()));
    }
  }
} 