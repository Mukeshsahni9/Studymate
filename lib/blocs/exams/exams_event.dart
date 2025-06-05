import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/exam.dart';

abstract class ExamsEvent extends Equatable {
  const ExamsEvent();

  @override
  List<Object?> get props => [];
}

class LoadExams extends ExamsEvent {}

class AddExam extends ExamsEvent {
  final String title;
  final String subject;
  final String location;
  final String duration;
  final DateTime date;
  final TimeOfDay time;

  const AddExam({
    required this.title,
    required this.subject,
    required this.location,
    required this.duration,
    required this.date,
    required this.time,
  });

  @override
  List<Object?> get props => [title, subject, location, duration, date, time];
}

class UpdateExam extends ExamsEvent {
  final Exam exam;

  const UpdateExam(this.exam);

  @override
  List<Object?> get props => [exam];
}

class DeleteExam extends ExamsEvent {
  final String id;

  const DeleteExam(this.id);

  @override
  List<Object?> get props => [id];
}

class MarkExamComplete extends ExamsEvent {
  final String id;
  final bool isComplete;

  const MarkExamComplete(this.id, this.isComplete);

  @override
  List<Object?> get props => [id, isComplete];
} 