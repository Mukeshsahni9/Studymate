import 'package:equatable/equatable.dart';

class Progress extends Equatable {
  final int completedPomodoros;
  final int completedAssignments;
  final int completedExams;
  final int studyStreak;
  final List<String> achievements;

  const Progress({
    this.completedPomodoros = 0,
    this.completedAssignments = 0,
    this.completedExams = 0,
    this.studyStreak = 0,
    this.achievements = const [],
  });

  Progress copyWith({
    int? completedPomodoros,
    int? completedAssignments,
    int? completedExams,
    int? studyStreak,
    List<String>? achievements,
  }) {
    return Progress(
      completedPomodoros: completedPomodoros ?? this.completedPomodoros,
      completedAssignments: completedAssignments ?? this.completedAssignments,
      completedExams: completedExams ?? this.completedExams,
      studyStreak: studyStreak ?? this.studyStreak,
      achievements: achievements ?? this.achievements,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'completedPomodoros': completedPomodoros,
      'completedAssignments': completedAssignments,
      'completedExams': completedExams,
      'studyStreak': studyStreak,
      'achievements': achievements,
    };
  }

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      completedPomodoros: json['completedPomodoros'] as int,
      completedAssignments: json['completedAssignments'] as int,
      completedExams: json['completedExams'] as int,
      studyStreak: json['studyStreak'] as int,
      achievements: List<String>.from(json['achievements'] as List),
    );
  }

  @override
  List<Object?> get props => [
        completedPomodoros,
        completedAssignments,
        completedExams,
        studyStreak,
        achievements,
      ];
} 