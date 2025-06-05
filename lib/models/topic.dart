enum TopicPriority {
  low,
  medium,
  high
}

enum RevisionFrequency {
  daily,
  weekly,
  biweekly,
  monthly
}

class Topic {
  final String id;
  final String title;
  final String subject;
  final TopicPriority priority;
  final RevisionFrequency frequency;
  final DateTime lastRevised;
  final bool isLearned;
  final String? notes;

  Topic({
    required this.id,
    required this.title,
    required this.subject,
    this.priority = TopicPriority.medium,
    this.frequency = RevisionFrequency.weekly,
    required this.lastRevised,
    this.isLearned = false,
    this.notes,
  });

  bool get needsRevision {
    final now = DateTime.now();
    final daysSinceLastRevision = now.difference(lastRevised).inDays;
    
    switch (frequency) {
      case RevisionFrequency.daily:
        return daysSinceLastRevision >= 1;
      case RevisionFrequency.weekly:
        return daysSinceLastRevision >= 7;
      case RevisionFrequency.biweekly:
        return daysSinceLastRevision >= 14;
      case RevisionFrequency.monthly:
        return daysSinceLastRevision >= 30;
    }
  }

  Topic copyWith({
    String? id,
    String? title,
    String? subject,
    TopicPriority? priority,
    RevisionFrequency? frequency,
    DateTime? lastRevised,
    bool? isLearned,
    String? notes,
  }) {
    return Topic(
      id: id ?? this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      priority: priority ?? this.priority,
      frequency: frequency ?? this.frequency,
      lastRevised: lastRevised ?? this.lastRevised,
      isLearned: isLearned ?? this.isLearned,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subject': subject,
      'priority': priority.toString(),
      'frequency': frequency.toString(),
      'lastRevised': lastRevised.toIso8601String(),
      'isLearned': isLearned,
      'notes': notes,
    };
  }

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      title: json['title'],
      subject: json['subject'],
      priority: TopicPriority.values.firstWhere(
        (e) => e.toString() == json['priority'],
        orElse: () => TopicPriority.medium,
      ),
      frequency: RevisionFrequency.values.firstWhere(
        (e) => e.toString() == json['frequency'],
        orElse: () => RevisionFrequency.weekly,
      ),
      lastRevised: DateTime.parse(json['lastRevised']),
      isLearned: json['isLearned'] ?? false,
      notes: json['notes'],
    );
  }
} 