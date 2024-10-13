
class Routine {
  final int? id;
  final String title;
  final String description;
  final String type;
  final String difficulty;

  Routine({
    this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.difficulty,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'difficulty': difficulty,
    };
  }

  static Routine fromMap(Map<String, dynamic> map) {
    return Routine(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      type: map['type'],
      difficulty: map['difficulty'],
    );
  }
}
