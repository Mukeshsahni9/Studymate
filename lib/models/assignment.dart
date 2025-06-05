enum AssignmentStatus {
  pending,
  completed,
  overdue
}

class Assignment {
  final String id;
  final String title;
  final String subject;
  final DateTime dueDate;
  final AssignmentStatus status;
  final String? description;
  final DateTime createdAt;

  Assignment({
    required this.id,
    required this.title,
    required this.subject,
    required this.dueDate,
    this.status = AssignmentStatus.pending,
    this.description,
    required this.createdAt,
  });

  Assignment copyWith({
    String? id,
    String? title,
    String? subject,
    DateTime? dueDate,
    AssignmentStatus? status,
    String? description,
    DateTime? createdAt,
  }) {
    return Assignment(
      id: id ?? this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subject': subject,
      'dueDate': dueDate.toIso8601String(),
      'status': status.toString(),
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'],
      title: json['title'],
      subject: json['subject'],
      dueDate: DateTime.parse(json['dueDate']),
      status: AssignmentStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => AssignmentStatus.pending,
      ),
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
} 