class Task {
  final int? id;
  final String title;
  final String description;
  final DateTime date;
  final String category;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      category: map['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'category': category,
    };
  }
}
