class Entry {
  final int id;
  final String exercise;
  final int sets;
  final int reps;

  Entry({
    required this.id,
    required this.exercise,
    required this.sets,
    required this.reps,
  });

  String get textRepr => '$sets × $reps';

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      id: json['id'],
      exercise: json['exercise'],
      sets: json['sets'],
      reps: json['reps'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exercise': exercise,
      'sets': sets,
      'reps': reps,
    };
  }

  Entry copyWith({
    int? id,
    String? exercise,
    int? sets,
    int? reps,
  }) {
    return Entry(
      id: id ?? this.id,
      exercise: exercise ?? this.exercise,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
    );
  }
}