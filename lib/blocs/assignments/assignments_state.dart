import 'package:equatable/equatable.dart';
import '../../models/assignment.dart';

class AssignmentsState extends Equatable {
  final List<Assignment> assignments;
  final bool isLoading;
  final String? error;

  const AssignmentsState({
    this.assignments = const [],
    this.isLoading = false,
    this.error,
  });

  AssignmentsState copyWith({
    List<Assignment>? assignments,
    bool? isLoading,
    String? error,
  }) {
    return AssignmentsState(
      assignments: assignments ?? this.assignments,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<Assignment> get upcomingAssignments {
    final now = DateTime.now();
    return assignments
        .where((assignment) => 
          assignment.status == AssignmentStatus.pending && 
          assignment.dueDate.isAfter(now))
        .toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  List<Assignment> get overdueAssignments {
    final now = DateTime.now();
    return assignments
        .where((assignment) => 
          assignment.status == AssignmentStatus.pending && 
          assignment.dueDate.isBefore(now))
        .toList()
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  List<Assignment> get completedAssignments {
    return assignments
        .where((assignment) => assignment.status == AssignmentStatus.completed)
        .toList()
      ..sort((a, b) => b.dueDate.compareTo(a.dueDate));
  }

  @override
  List<Object?> get props => [assignments, isLoading, error];
} 