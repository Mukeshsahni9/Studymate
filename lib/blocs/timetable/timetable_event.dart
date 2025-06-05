import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../models/timetable_event.dart' as model;

abstract class TimetableEvent extends Equatable {
  const TimetableEvent();

  @override
  List<Object?> get props => [];
}

class LoadTimetable extends TimetableEvent {}

class AddTimetable extends TimetableEvent {
  final String subject;
  final String teacher;
  final String room;
  final String taskType;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<int> days;

  const AddTimetable({
    required this.subject,
    required this.teacher,
    required this.room,
    required this.taskType,
    required this.startTime,
    required this.endTime,
    required this.days,
  });

  @override
  List<Object?> get props => [subject, teacher, room, taskType, startTime, endTime, days];
}

class DeleteTimetable extends TimetableEvent {
  final String id;

  const DeleteTimetable(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateTimetableEvent extends TimetableEvent {
  final model.TimetableEvent event;

  const UpdateTimetableEvent(this.event);

  @override
  List<Object?> get props => [event];
} 