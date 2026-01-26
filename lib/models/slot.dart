import 'entry.dart';

class Slot {
  final int id;
  final int order;
  final String comment;
  final List<Entry> entries;

  Slot({
    required this.id,
    required this.order,
    required this.comment,
    required this.entries,
  });

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      id: json['id'],
      order: json['order'],
      comment: json['comment'] ?? '',
      entries:
          (json['entries'] as List?)
              ?.map(
                (e) => Entry.fromJson(e), //
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': order,
      'comment': comment,
      'entries': entries.map((e) => e.toJson()).toList(),
    };
  }

  Slot copyWith({int? id, int? order, String? comment, List<Entry>? entries}) {
    return Slot(
      id: id ?? this.id,
      order: order ?? this.order,
      comment: comment ?? this.comment,
      entries: entries ?? this.entries,
    );
  }
}
