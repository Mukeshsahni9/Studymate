import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../models/topic.dart';
import 'topics_event.dart';
import 'topics_state.dart';

class TopicsBloc extends Bloc<TopicsEvent, TopicsState> {
  static const String _storageKey = 'topics';
  final _uuid = const Uuid();
  final SharedPreferences prefs;

  TopicsBloc(this.prefs) : super(const TopicsState()) {
    on<LoadTopics>(_onLoadTopics);
    on<AddTopic>(_onAddTopic);
    on<UpdateTopic>(_onUpdateTopic);
    on<DeleteTopic>(_onDeleteTopic);
    on<UpdateLastRevised>(_onUpdateLastRevised);
  }

  Future<void> _onLoadTopics(LoadTopics event, Emitter<TopicsState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      final topicsJson = prefs.getStringList(_storageKey) ?? [];
      final topics = topicsJson
          .map((json) => Topic.fromJson(jsonDecode(json)))
          .toList();
      emit(state.copyWith(topics: topics, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to load topics: ${e.toString()}',
      ));
    }
  }

  Future<void> _onAddTopic(AddTopic event, Emitter<TopicsState> emit) async {
    try {
      final topic = Topic(
        id: _uuid.v4(),
        title: event.title,
        subject: event.subject,
        priority: event.priority,
        frequency: event.frequency,
        lastRevised: event.lastRevised,
        notes: event.description.isEmpty ? null : event.description,
      );

      final updatedTopics = List<Topic>.from(state.topics)..add(topic);
      await _saveTopics(updatedTopics);
      emit(state.copyWith(topics: updatedTopics));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to add topic: ${e.toString()}',
      ));
    }
  }

  Future<void> _onUpdateTopic(UpdateTopic event, Emitter<TopicsState> emit) async {
    try {
      final updatedTopics = state.topics.map((topic) {
        if (topic.id == event.topic.id) {
          return event.topic;
        }
        return topic;
      }).toList();

      await _saveTopics(updatedTopics);
      emit(state.copyWith(topics: updatedTopics));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to update topic: ${e.toString()}',
      ));
    }
  }

  Future<void> _onDeleteTopic(DeleteTopic event, Emitter<TopicsState> emit) async {
    try {
      final updatedTopics = state.topics
          .where((topic) => topic.id != event.id)
          .toList();

      await _saveTopics(updatedTopics);
      emit(state.copyWith(topics: updatedTopics));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to delete topic: ${e.toString()}',
      ));
    }
  }

  Future<void> _onUpdateLastRevised(
    UpdateLastRevised event,
    Emitter<TopicsState> emit,
  ) async {
    try {
      final updatedTopics = state.topics.map((topic) {
        if (topic.id == event.id) {
          return topic.copyWith(lastRevised: event.lastRevised);
        }
        return topic;
      }).toList();

      await _saveTopics(updatedTopics);
      emit(state.copyWith(topics: updatedTopics));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to update last revised date: ${e.toString()}',
      ));
    }
  }

  Future<void> _saveTopics(List<Topic> topics) async {
    final topicsJson = topics
        .map((topic) => jsonEncode(topic.toJson()))
        .toList();
    await prefs.setStringList(_storageKey, topicsJson);
  }
} 