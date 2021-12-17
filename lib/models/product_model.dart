class Product {
  final String name;
  final double cost;
  final String id;
  int quantity;

  Product({
    this.quantity = 1,
    required this.name,
    required this.cost,
    required this.id,
  });
}
