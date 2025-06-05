import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/timetable.dart';
import 'timetable_event.dart';
import 'timetable_state.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  final SharedPreferences _prefs;
  static const String _timetableKey = 'timetables';

  TimetableBloc(this._prefs) : super(const TimetableState()) {
    on<LoadTimetable>(_onLoadTimetable);
    on<AddTimetable>(_onAddTimetable);
    on<DeleteTimetable>(_onDeleteTimetable);
  }

  Future<void> _onLoadTimetable(LoadTimetable event, Emitter<TimetableState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final timetablesJson = _prefs.getStringList(_timetableKey) ?? [];
      final timetables = timetablesJson
          .map((json) => Timetable.fromJson(jsonDecode(json)))
          .toList();
      emit(state.copyWith(timetables: timetables, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void _onAddTimetable(AddTimetable event, Emitter<TimetableState> emit) {
    final timetable = Timetable(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      subject: event.subject,
      teacher: event.teacher,
      room: event.room,
      taskType: event.taskType,
      startTime: event.startTime,
      endTime: event.endTime,
      days: event.days,
    );
    final updatedTimetables = List<Timetable>.from(state.timetables)..add(timetable);
    _saveTimetables(updatedTimetables);
    emit(TimetableState(timetables: updatedTimetables));
  }

  Future<void> _onDeleteTimetable(DeleteTimetable event, Emitter<TimetableState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final updatedTimetables = state.timetables
          .where((timetable) => timetable.id != event.id)
          .toList();
      await _saveTimetables(updatedTimetables);
      emit(state.copyWith(timetables: updatedTimetables, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _saveTimetables(List<Timetable> timetables) async {
    final timetablesJson = timetables
        .map((timetable) => jsonEncode(timetable.toJson()))
        .toList();
    await _prefs.setStringList(_timetableKey, timetablesJson);
  }
} 