class HomeModel {
  final int successOrders;
  final int pendingOrders;
  final int cancelledOrders;
  final int orders;

  HomeModel({
    required this.successOrders,
    required this.pendingOrders,
    required this.cancelledOrders,
    required this.orders,
  });

  // Factory method to create an instance from JSON data
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      successOrders: json['successOrders'],
      pendingOrders: json['pendingOrders'],
      cancelledOrders: json['cancelledOrders'],
      orders: json['orders'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'successOrders': successOrders,
      'pendingOrders': pendingOrders,
      'cancelledOrders': cancelledOrders,
      'orders': orders,
    };
  }
}
