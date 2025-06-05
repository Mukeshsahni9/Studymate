import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Timetable extends Equatable {
  final String id;
  final String subject;
  final String teacher;
  final String room;
  final String taskType;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<int> days; // 1 = Monday, 7 = Sunday

  const Timetable({
    required this.id,
    required this.subject,
    required this.teacher,
    required this.room,
    required this.taskType,
    required this.startTime,
    required this.endTime,
    required this.days,
  });

  @override
  List<Object?> get props => [
        id,
        subject,
        teacher,
        room,
        taskType,
        startTime,
        endTime,
        days,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'teacher': teacher,
      'room': room,
      'taskType': taskType,
      'startTime': '${startTime.hour}:${startTime.minute}',
      'endTime': '${endTime.hour}:${endTime.minute}',
      'days': days,
    };
  }

  factory Timetable.fromJson(Map<String, dynamic> json) {
    final startTimeParts = (json['startTime'] as String).split(':');
    final endTimeParts = (json['endTime'] as String).split(':');

    return Timetable(
      id: json['id'] as String,
      subject: json['subject'] as String,
      teacher: json['teacher'] as String,
      room: json['room'] as String,
      taskType: json['taskType'] as String,
      startTime: TimeOfDay(
        hour: int.parse(startTimeParts[0]),
        minute: int.parse(startTimeParts[1]),
      ),
      endTime: TimeOfDay(
        hour: int.parse(endTimeParts[0]),
        minute: int.parse(endTimeParts[1]),
      ),
      days: List<int>.from(json['days'] as List),
    );
  }
} 