class Product {
  final String id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      name: map['name'] as String? ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
    };
  }
}
