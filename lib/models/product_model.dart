class ProductModel {
  final int id;
  final String name;
  final String quantity;
  final double unitPrice;
  final double totalPrice;

  ProductModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      unitPrice: double.parse(json['unit_price']),
      totalPrice: double.parse(json['total_price']),
    );
  }

  // تحويل من كائن Dart إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit_price': unitPrice.toString(),
      'total_price': totalPrice.toString(),
    };
  }
}

class OrderModel {
  final List<ProductModel> products;

  OrderModel({
    required this.products,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      products: (json['products'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
