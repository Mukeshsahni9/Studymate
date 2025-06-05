import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Exam extends Equatable {
  final String id;
  final String title;
  final String subject;
  final String location;
  final String duration;
  final DateTime date;
  final TimeOfDay time;

  const Exam({
    required this.id,
    required this.title,
    required this.subject,
    required this.location,
    required this.duration,
    required this.date,
    required this.time,
  });

  @override
  List<Object?> get props => [id, title, subject, location, duration, date, time];

  int get daysUntilExam {
    return date.difference(DateTime.now()).inDays;
  }

  Exam copyWith({
    String? id,
    String? subject,
    String? title,
    DateTime? date,
    String? location,
    String? duration,
    TimeOfDay? time,
  }) {
    return Exam(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      title: title ?? this.title,
      date: date ?? this.date,
      location: location ?? this.location,
      duration: duration ?? this.duration,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subject': subject,
      'location': location,
      'duration': duration,
      'date': date.toIso8601String(),
      'time': '${time.hour}:${time.minute}',
    };
  }

  factory Exam.fromJson(Map<String, dynamic> json) {
    final timeParts = (json['time'] as String).split(':');
    return Exam(
      id: json['id'],
      title: json['title'],
      subject: json['subject'],
      location: json['location'],
      duration: json['duration'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      ),
    );
  }
} 