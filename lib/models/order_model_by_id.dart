// import 'package:happy_chicken_restaurant/models/product_model.dart';
//
// class OrderModelById {
//   final String id;
//   final OrderAttributes attributes;
//   final OrderRelationships relationships;
//
//   OrderModelById({
//     required this.id,
//     required this.attributes,
//     required this.relationships,
//   });
//
//   factory OrderModelById.fromJson(Map<String, dynamic> json) {
//     return OrderModelById(
//       id: json['id'].toString(),
//       attributes: OrderAttributes.fromJson(json['attributes']),
//       relationships: OrderRelationships.fromJson(json['relationships']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'attributes': attributes.toJson(),
//       'relationships': relationships.toJson(),
//     };
//   }
// }
//
// class OrderAttributes {
//   final String number;
//   final String status;
//   final Location location;
//   final String orderType;
//   final String paymentMethod;
//   final String imagePath;
//   final String totalPrice;
//   final String createdAt;
//
//   OrderAttributes({
//     required this.number,
//     required this.status,
//     required this.location,
//     required this.orderType,
//     required this.paymentMethod,
//     required this.imagePath,
//     required this.totalPrice,
//     required this.createdAt,
//   });
//
//   factory OrderAttributes.fromJson(Map<String, dynamic> json) {
//     return OrderAttributes(
//       number: json['number'].toString(),
//       status: json['status'],
//       location: Location.fromJson(json['location']),
//       orderType: json['order_type'],
//       paymentMethod: json['payment_method'],
//       imagePath: json['imagePath'],
//       totalPrice: json['totalPrice'],
//       createdAt: json['created_at'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'number': number,
//       'status': status,
//       'location': location.toJson(),
//       'order_type': orderType,
//       'payment_method': paymentMethod,
//       'imagePath': imagePath,
//       'totalPrice': totalPrice,
//       'created_at': createdAt,
//     };
//   }
// }
//
// class Location {
//   final String lat;
//   final String lng;
//
//   Location({required this.lat, required this.lng});
//
//   factory Location.fromJson(Map<String, dynamic> json) {
//     return Location(
//       lat: json['lat'],
//       lng: json['lng'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'lat': lat,
//       'lng': lng,
//     };
//   }
// }
//
// class OrderRelationships {
//   final User user;
//   final List<ProductModel> products;
//
//   OrderRelationships({required this.user, required this.products});
//
//   factory OrderRelationships.fromJson(Map<String, dynamic> json) {
//     return OrderRelationships(
//       user: User.fromJson(json['user']),
//       products: (json['products'] as List)
//           .map((productJson) => ProductModel.fromJson(productJson))
//           .toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'user': user.toJson(),
//       'products': products.map((product) => product.toJson()).toList(),
//     };
//   }
// }
//
// class User {
//   final String name;
//   final String email;
//   final String phone;
//   final String imagePath;
//   final int points;
//   final String inviteCode;
//
//   User({
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.imagePath,
//     required this.points,
//     required this.inviteCode,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       name: json['attributes']['name'],
//       email: json['attributes']['email'],
//       phone: json['attributes']['phone'],
//       imagePath: json['attributes']['imagePath'],
//       points: json['attributes']['points'],
//       inviteCode: json['attributes']['inviteCode'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'attributes': {
//         'name': name,
//         'email': email,
//         'phone': phone,
//         'imagePath': imagePath,
//         'points': points,
//         'inviteCode': inviteCode,
//       },
//     };
//   }
// }
//
//
