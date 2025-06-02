class ProductDataModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory ProductDataModel.fromFirestore(
    Map<String, dynamic> data,
    String docId,
  ) {
    return ProductDataModel(
      id: docId,
      name: data['name'] as String,
      description: data['description'] as String,
      price: (data['price'] as num).toDouble(),
      imageUrl: data['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'name': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
      };
}
