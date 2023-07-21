class CartItem {
  final String id;
  final String productId;
  final String name;
  final String imageUrl;
  final int quantity;
  final double price;

  const CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });
}
