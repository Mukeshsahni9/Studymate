import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../blocs/assignments/assignments_bloc.dart';
import '../blocs/assignments/assignments_event.dart';
import '../blocs/assignments/assignments_state.dart';
import '../models/assignment.dart';
import '../utils/theme.dart';

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AssignmentsBloc>().add(LoadAssignments());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
      ),
      body: BlocBuilder<AssignmentsBloc, AssignmentsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text(state.error!, style: TextStyle(color: Colors.red)));
          }
          if (state.assignments.isEmpty) {
            return Center(
              child: Text('No assignments yet', style: AppTheme.titleLarge),
            );
          }
          return ListView.builder(
            itemCount: state.assignments.length,
            itemBuilder: (context, index) {
              final assignment = state.assignments[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(assignment.title),
                  subtitle: Text('Due: ${_formatDate(assignment.dueDate)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: assignment.status == AssignmentStatus.completed,
                        onChanged: (value) {
                          context.read<AssignmentsBloc>().add(
                                MarkAssignmentComplete(assignment.id, value ?? false),
                              );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<AssignmentsBloc>().add(DeleteAssignment(assignment.id));
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAssignmentDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddAssignmentDialog() {
    final titleController = TextEditingController();
    final subjectController = TextEditingController();
    final descriptionController = TextEditingController();
    DateTime? dueDate;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Assignment'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: subjectController,
                  decoration: const InputDecoration(labelText: 'Subject'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Due Date:'),
                    const SizedBox(width: 8),
                    Text(dueDate == null ? 'Select' : _formatDate(dueDate)),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(const Duration(days: 365)),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null) {
                          setState(() {
                            dueDate = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    subjectController.text.isNotEmpty &&
                    dueDate != null) {
                  context.read<AssignmentsBloc>().add(
                        AddAssignment(
                          title: titleController.text,
                          subject: subjectController.text,
                          description: descriptionController.text,
                          dueDate: dueDate!,
                          priority: 1,
                        ),
                      );
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year}';
  }
} 