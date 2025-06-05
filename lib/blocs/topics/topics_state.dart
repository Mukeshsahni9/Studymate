import 'package:equatable/equatable.dart';
import '../../models/topic.dart';

class TopicsState extends Equatable {
  final List<Topic> topics;
  final bool isLoading;
  final String? error;

  const TopicsState({
    this.topics = const [],
    this.isLoading = false,
    this.error,
  });

  TopicsState copyWith({
    List<Topic>? topics,
    bool? isLoading,
    String? error,
  }) {
    return TopicsState(
      topics: topics ?? this.topics,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  List<Topic> get needsRevision {
    final now = DateTime.now();
    return topics.where((topic) {
      final daysSinceLastRevision = now.difference(topic.lastRevised).inDays;
      final revisionDays = switch (topic.frequency) {
        RevisionFrequency.daily => 1,
        RevisionFrequency.weekly => 7,
        RevisionFrequency.biweekly => 14,
        RevisionFrequency.monthly => 30,
      };
      return daysSinceLastRevision >= revisionDays;
    }).toList()
      ..sort((a, b) => a.lastRevised.compareTo(b.lastRevised));
  }

  List<Topic> get upcomingRevisions {
    final now = DateTime.now();
    return topics.where((topic) {
      final daysSinceLastRevision = now.difference(topic.lastRevised).inDays;
      final revisionDays = switch (topic.frequency) {
        RevisionFrequency.daily => 1,
        RevisionFrequency.weekly => 7,
        RevisionFrequency.biweekly => 14,
        RevisionFrequency.monthly => 30,
      };
      return daysSinceLastRevision < revisionDays;
    }).toList()
      ..sort((a, b) => a.lastRevised.compareTo(b.lastRevised));
  }

  @override
  List<Object?> get props => [topics, isLoading, error];
} 