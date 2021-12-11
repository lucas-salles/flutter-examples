import 'dart:convert';

class OrderModel {
  final String id;
  final String name;
  final double price;
  final String created;

  OrderModel({
    required this.id,
    required this.name,
    required this.price,
    required this.created,
  });

  OrderModel copyWith({
    String? id,
    String? name,
    double? price,
    String? created,
  }) {
    return OrderModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      created: created ?? this.created,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'created': created,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      created: map['created'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, name: $name, price: $price, created: $created)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.created == created;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ price.hashCode ^ created.hashCode;
  }
}
