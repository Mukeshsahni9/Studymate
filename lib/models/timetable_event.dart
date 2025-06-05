import 'package:equatable/equatable.dart';

class TimetableEvent extends Equatable {
  final String id;
  final String title;
  final String subject;
  final DateTime startTime;
  final DateTime endTime;
  final String? description;

  const TimetableEvent({
    required this.id,
    required this.title,
    required this.subject,
    required this.startTime,
    required this.endTime,
    this.description,
  });

  TimetableEvent copyWith({
    String? id,
    String? title,
    String? subject,
    DateTime? startTime,
    DateTime? endTime,
    String? description,
  }) {
    return TimetableEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subject': subject,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'description': description,
    };
  }

  factory TimetableEvent.fromJson(Map<String, dynamic> json) {
    return TimetableEvent(
      id: json['id'] as String,
      title: json['title'] as String,
      subject: json['subject'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      description: json['description'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, title, subject, startTime, endTime, description];
} 