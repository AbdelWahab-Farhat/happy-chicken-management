import 'package:happy_chicken_restaurant/models/product_model.dart';

class OrderModel {
  final String type;
  final int id;
  final OrderAttributes attributes;
  final OrderRelationships relationships;

  OrderModel({
    required this.type,
    required this.id,
    required this.attributes,
    required this.relationships,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      type: json["type"],
      id: json["id"],
      attributes: OrderAttributes.fromJson(json["attributes"]),
      relationships: OrderRelationships.fromJson(json["relationships"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "id": id,
      "attributes": attributes.toJson(),
      "relationships": relationships.toJson(),
    };
  }
}

class OrderAttributes {
  final String orderNumber;
  final String status;
  final Location location;
  final String orderType;
  final String paymentMethod;
  final String imagePath;
  final String deliveryPrice;
  final String totalPrice;
  final DateTime createdAt;

  OrderAttributes({
    required this.orderNumber,
    required this.status,
    required this.location,
    required this.orderType,
    required this.paymentMethod,
    required this.imagePath,
    required this.deliveryPrice,
    required this.totalPrice,
    required this.createdAt,
  });

  factory OrderAttributes.fromJson(Map<String, dynamic> json) {
    return OrderAttributes(
      orderNumber: json["number"].toString(),
      status: json["status"],
      location: Location.fromJson(json["location"]),
      orderType: json["order_type"],
      paymentMethod: json["payment_method"],
      imagePath: json["imagePath"],
      deliveryPrice: json["deliveryPrice"].toString(),
      totalPrice: json["totalPrice"].toString(),
      createdAt: DateTime.parse(json["created_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "number": orderNumber,
      "status": status,
      "location": location.toJson(),
      "order_type": orderType,
      "payment_method": paymentMethod,
      "imagePath": imagePath,
      "deliveryPrice": deliveryPrice,
      "totalPrice": totalPrice,
      "created_at": createdAt.toIso8601String(),
    };
  }
}

class Location {
  final String lat;
  final String lng;

  Location({required this.lat, required this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json["lat"].toString().trim(),
      lng: json["lng"].toString().trim(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lng": lng,
    };
  }
}

class OrderRelationships {
  final User user;
  final List<ProductModel> products;

  OrderRelationships({required this.user, required this.products});

  factory OrderRelationships.fromJson(Map<String, dynamic> json) {
    return OrderRelationships(
      user: User.fromJson(json["user"]),
      products: (json["products"] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": user.toJson(),
      "products": products.map((e) => e.toJson()).toList(),
    };
  }
}

class User {
  final String type;
  final int id;
  final UserAttributes attributes;

  User({required this.type, required this.id, required this.attributes});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      type: json["type"],
      id: json["id"],
      attributes: UserAttributes.fromJson(json["attributes"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "id": id,
      "attributes": attributes.toJson(),
    };
  }
}

class UserAttributes {
  final String name;
  final String email;
  final String phone;
  final String imagePath;
  final String points;
  final String inviteCode;

  UserAttributes({
    required this.name,
    required this.email,
    required this.phone,
    required this.imagePath,
    required this.points,
    required this.inviteCode,
  });

  factory UserAttributes.fromJson(Map<String, dynamic> json) {
    return UserAttributes(
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      imagePath: json["imagePath"],
      points: json["points"].toString(),
      inviteCode: json["inviteCode"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "imagePath": imagePath,
      "points": points,
      "inviteCode": inviteCode,
    };
  }
}
