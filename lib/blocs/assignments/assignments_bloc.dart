import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/assignment.dart';
import 'assignments_event.dart';
import 'assignments_state.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class AssignmentsBloc extends Bloc<AssignmentsEvent, AssignmentsState> {
  final SharedPreferences prefs;
  static const String assignmentsKey = 'assignments';

  AssignmentsBloc(this.prefs) : super(const AssignmentsState()) {
    on<LoadAssignments>(_onLoadAssignments);
    on<AddAssignment>(_onAddAssignment);
    on<UpdateAssignment>(_onUpdateAssignment);
    on<DeleteAssignment>(_onDeleteAssignment);
    on<MarkAssignmentComplete>(_onMarkAssignmentComplete);
  }

  Future<void> _onLoadAssignments(LoadAssignments event, Emitter<AssignmentsState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final assignmentsJson = prefs.getStringList(assignmentsKey) ?? [];
      final assignments = assignmentsJson
          .map((jsonStr) => Assignment.fromJson(json.decode(jsonStr)))
          .toList();
      emit(state.copyWith(assignments: assignments, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: 'Failed to load assignments: $e'));
    }
  }

  Future<void> _onAddAssignment(AddAssignment event, Emitter<AssignmentsState> emit) async {
    try {
      final newAssignment = Assignment(
        id: const Uuid().v4(),
        title: event.title,
        subject: event.subject,
        dueDate: event.dueDate,
        status: AssignmentStatus.pending,
        description: event.description,
        createdAt: DateTime.now(),
      );
      final updatedAssignments = List<Assignment>.from(state.assignments)..add(newAssignment);
      await _saveAssignments(updatedAssignments);
      emit(state.copyWith(assignments: updatedAssignments));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to add assignment: $e'));
    }
  }

  Future<void> _onUpdateAssignment(UpdateAssignment event, Emitter<AssignmentsState> emit) async {
    try {
      final updatedAssignments = state.assignments.map((a) => a.id == event.assignment.id ? event.assignment : a).toList();
      await _saveAssignments(updatedAssignments);
      emit(state.copyWith(assignments: updatedAssignments));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to update assignment: $e'));
    }
  }

  Future<void> _onDeleteAssignment(DeleteAssignment event, Emitter<AssignmentsState> emit) async {
    try {
      final updatedAssignments = state.assignments.where((a) => a.id != event.id).toList();
      await _saveAssignments(updatedAssignments);
      emit(state.copyWith(assignments: updatedAssignments));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to delete assignment: $e'));
    }
  }

  Future<void> _onMarkAssignmentComplete(MarkAssignmentComplete event, Emitter<AssignmentsState> emit) async {
    try {
      final updatedAssignments = state.assignments.map((a) {
        if (a.id == event.id) {
          return a.copyWith(
            status: event.isComplete ? AssignmentStatus.completed : AssignmentStatus.pending,
          );
        }
        return a;
      }).toList();
      await _saveAssignments(updatedAssignments);
      emit(state.copyWith(assignments: updatedAssignments));
    } catch (e) {
      emit(state.copyWith(error: 'Failed to update assignment status: $e'));
    }
  }

  Future<void> _saveAssignments(List<Assignment> assignments) async {
    final assignmentsJson = assignments.map((a) => json.encode(a.toJson())).toList();
    await prefs.setStringList(assignmentsKey, assignmentsJson);
  }
} 