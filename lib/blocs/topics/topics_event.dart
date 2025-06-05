import 'package:equatable/equatable.dart';
import '../../models/topic.dart';

abstract class TopicsEvent extends Equatable {
  const TopicsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTopics extends TopicsEvent {}

class AddTopic extends TopicsEvent {
  final String title;
  final String subject;
  final String description;
  final TopicPriority priority;
  final RevisionFrequency frequency;
  final DateTime lastRevised;

  const AddTopic({
    required this.title,
    required this.subject,
    required this.description,
    required this.priority,
    required this.frequency,
    required this.lastRevised,
  });

  @override
  List<Object?> get props => [
        title,
        subject,
        description,
        priority,
        frequency,
        lastRevised,
      ];
}

class UpdateTopic extends TopicsEvent {
  final Topic topic;

  const UpdateTopic(this.topic);

  @override
  List<Object?> get props => [topic];
}

class DeleteTopic extends TopicsEvent {
  final String id;

  const DeleteTopic(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateLastRevised extends TopicsEvent {
  final String id;
  final DateTime lastRevised;

  const UpdateLastRevised(this.id, this.lastRevised);

  @override
  List<Object?> get props => [id, lastRevised];
} 