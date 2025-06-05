import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import '../../models/exam.dart';
import '../progress/progress_bloc.dart';
import '../progress/progress_event.dart';
import 'exams_event.dart';
import 'exams_state.dart';

class ExamsBloc extends Bloc<ExamsEvent, ExamsState> {
  final SharedPreferences prefs;
  final ProgressBloc progressBloc;
  static const String _examsKey = 'exams';

  ExamsBloc(this.prefs, {required this.progressBloc}) : super(const ExamsState()) {
    on<LoadExams>(_onLoadExams);
    on<AddExam>(_onAddExam);
    on<DeleteExam>(_onDeleteExam);
  }

  Future<void> _onLoadExams(LoadExams event, Emitter<ExamsState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final examsJson = prefs.getString(_examsKey);
      if (examsJson != null) {
        final List<dynamic> decoded = json.decode(examsJson);
        final exams = decoded.map((json) => Exam.fromJson(json)).toList();
        emit(state.copyWith(exams: exams, isLoading: false));
      } else {
        emit(state.copyWith(exams: [], isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> _onAddExam(AddExam event, Emitter<ExamsState> emit) async {
    try {
      final exam = Exam(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: event.title,
        subject: event.subject,
        location: event.location,
        duration: event.duration,
        date: event.date,
        time: event.time,
      );

      final updatedExams = [...state.exams, exam];
      await _saveExams(updatedExams);
      emit(state.copyWith(exams: updatedExams));

      // Add achievement for first exam
      if (updatedExams.length == 1) {
        progressBloc.add(
          const AddAchievement('First Exam Scheduled! 📝'),
        );
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onDeleteExam(DeleteExam event, Emitter<ExamsState> emit) async {
    try {
      final updatedExams = state.exams.where((exam) => exam.id != event.id).toList();
      await _saveExams(updatedExams);
      emit(state.copyWith(exams: updatedExams));

      // Add achievement for completing an exam
      progressBloc.add(
        const AddAchievement('Exam Completed! 🎓'),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _saveExams(List<Exam> exams) async {
    final examsJson = json.encode(exams.map((exam) => exam.toJson()).toList());
    await prefs.setString(_examsKey, examsJson);
  }
} 