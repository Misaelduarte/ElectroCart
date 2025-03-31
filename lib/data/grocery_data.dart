class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class GroceryData {
  static List<Product> groceryProducts = [
    Product(
      id: '1',
      name: 'Iphone 15',
      description: 'Iphone top de linha com 128GB de armazenamento.',
      price: 5099.00,
      imageUrl:
          'https://images.pexels.com/photos/29020349/pexels-photo-29020349.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    Product(
      id: '2',
      name: 'MacBook Pro',
      description: 'MacBook com desempenho para alta performance.',
      price: 5499.99,
      imageUrl:
          'https://images.pexels.com/photos/249538/pexels-photo-249538.jpeg?auto=compress&cs=tinysrgb&w=600',
    ),
    Product(
      id: '3',
      name: 'Smart TV',
      description: 'TV 4K com cores vibrantes e tecnologia HDR.',
      price: 3999.99,
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1661386068437-3c1134b4d46b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8U21hcnQlMjBUVnxlbnwwfHwwfHx8MA%3D%3D',
    ),
    Product(
      id: '4',
      name: 'Headphones Sony',
      description: 'Fones de ouvido com cancelamento de ruído avançado.',
      price: 1299.99,
      imageUrl:
          'https://images.unsplash.com/photo-1612858250434-b5358e2b3625?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NzF8fEhlYWRwaG9uZXMlMjBTb255fGVufDB8fDB8fHww',
    ),
    Product(
      id: '5',
      name: 'Console PlayStation 5',
      description: 'Console de última geração para jogos incríveis.',
      price: 4499.99,
      imageUrl:
          'https://images.unsplash.com/photo-1605296830714-7c02e14957ac?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8UGxheVN0YXRpb24lMjA1fGVufDB8fDB8fHww',
    ),
  ];
}
