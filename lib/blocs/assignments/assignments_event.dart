import 'package:equatable/equatable.dart';
import '../../models/assignment.dart';

abstract class AssignmentsEvent extends Equatable {
  const AssignmentsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAssignments extends AssignmentsEvent {}

class AddAssignment extends AssignmentsEvent {
  final String title;
  final String subject;
  final String description;
  final DateTime dueDate;
  final int priority;

  const AddAssignment({
    required this.title,
    required this.subject,
    required this.description,
    required this.dueDate,
    required this.priority,
  });

  @override
  List<Object?> get props => [title, subject, description, dueDate, priority];
}

class UpdateAssignment extends AssignmentsEvent {
  final Assignment assignment;

  const UpdateAssignment(this.assignment);

  @override
  List<Object?> get props => [assignment];
}

class DeleteAssignment extends AssignmentsEvent {
  final String id;

  const DeleteAssignment(this.id);

  @override
  List<Object?> get props => [id];
}

class MarkAssignmentComplete extends AssignmentsEvent {
  final String id;
  final bool isComplete;

  const MarkAssignmentComplete(this.id, this.isComplete);

  @override
  List<Object?> get props => [id, isComplete];
} 