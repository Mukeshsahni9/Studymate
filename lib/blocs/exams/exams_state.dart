import 'package:equatable/equatable.dart';
import '../../models/exam.dart';

class ExamsState extends Equatable {
  final List<Exam> exams;
  final bool isLoading;
  final String? error;

  const ExamsState({
    this.exams = const [],
    this.isLoading = false,
    this.error,
  });

  List<Exam> get upcomingExams => exams
      .where((exam) => exam.date.isAfter(DateTime.now()))
      .toList()
    ..sort((a, b) => a.date.compareTo(b.date));

  List<Exam> get pastExams => exams
      .where((exam) => exam.date.isBefore(DateTime.now()))
      .toList()
    ..sort((a, b) => b.date.compareTo(a.date));

  ExamsState copyWith({
    List<Exam>? exams,
    bool? isLoading,
    String? error,
  }) {
    return ExamsState(
      exams: exams ?? this.exams,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [exams, isLoading, error];
} 