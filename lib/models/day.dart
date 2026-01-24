import 'slot.dart';

class Day {
  final int id;
  final int order;
  final String typeOf;
  final List<Slot> slots;

  Day({
    required this.id,
    required this.order,
    required this.typeOf,
    required this.slots,
  });

  bool get isRest => typeOf.toLowerCase() == 'rest';

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      id: json['id'],
      order: json['order'],
      typeOf: json['type_of'],
      slots: (json['slots'] as List?)
              ?.map((s) => Slot.fromJson(s))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': order,
      'type_of': typeOf,
      'slots': slots.map((s) => s.toJson()).toList(),
    };
  }

  Day copyWith({
    int? id,
    int? order,
    String? typeOf,
    List<Slot>? slots,
  }) {
    return Day(
      id: id ?? this.id,
      order: order ?? this.order,
      typeOf: typeOf ?? this.typeOf,
      slots: slots ?? this.slots,
    );
  }
}