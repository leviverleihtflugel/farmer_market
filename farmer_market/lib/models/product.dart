class Product {
  final String id;
  final String name;
  final double price;
  final String? imageUrl;
  final String? description;
  final String? sellerPhone;
  final int stockKg;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    this.description,
    this.sellerPhone,
    required this.stockKg,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      name: map['name'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'],
      description: map['description'],
      sellerPhone: map['sellerPhone'],
      stockKg: (map['stockKg'] ?? 0) as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'sellerPhone': sellerPhone,
      'stockKg': stockKg,
    };
  }
}
