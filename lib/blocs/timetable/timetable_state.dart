import 'package:equatable/equatable.dart';
import '../../models/timetable.dart';

class TimetableState extends Equatable {
  final List<Timetable> timetables;
  final bool isLoading;
  final String? error;

  const TimetableState({
    this.timetables = const [],
    this.isLoading = false,
    this.error,
  });

  List<Timetable> getTimetablesForDay(int day) {
    return timetables.where((timetable) => timetable.days.contains(day)).toList()
      ..sort((a, b) => a.startTime.hour.compareTo(b.startTime.hour));
  }

  TimetableState copyWith({
    List<Timetable>? timetables,
    bool? isLoading,
    String? error,
  }) {
    return TimetableState(
      timetables: timetables ?? this.timetables,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [timetables, isLoading, error];
} 