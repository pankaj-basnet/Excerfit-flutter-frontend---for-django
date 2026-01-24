class Routine {
  final int id;
  final DateTime start;
  final DateTime end;
  final String owner;
  final List<RelatedRoutine> relatedRoutines;

  Routine({
    required this.id,
    required this.start,
    required this.end,
    required this.owner,
    required this.relatedRoutines,
  });

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      id: json['id'],
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      owner: json['owner'],
      relatedRoutines: (json['related_routines'] as List)
          .map((r) => RelatedRoutine.fromJson(r))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start': start.toIso8601String().split('T')[0],
      'end': end.toIso8601String().split('T')[0],
      'owner': owner,
      'related_routines': relatedRoutines.map((r) => r.toJson()).toList(),
    };
  }
}

class RelatedRoutine {
  final int id;
  final String name;

  RelatedRoutine({
    required this.id,
    required this.name,
  });

  factory RelatedRoutine.fromJson(Map<String, dynamic> json) {
    return RelatedRoutine(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}