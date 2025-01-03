class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String genre;
  final String level;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.genre,
    required this.level,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      genre: json['genre'],
      level: json['level'],
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
