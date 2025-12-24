class UserModel {
  final int id;
  final String title;
  final String address;
  final String imagePath;
  final String phone;
  final String description;
  final Location location;
  final String email;

  UserModel({
    required this.id,
    required this.title,
    required this.address,
    required this.imagePath,
    required this.phone,
    required this.description,
    required this.location,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      title: json['attributes']['title'] as String,
      address: json['attributes']['address'] as String,
      imagePath: json['attributes']['imagePath'] as String,
      phone: json['attributes']['phone'] as String,
      description: json['attributes']['description'] as String,
      location: Location.fromJson(json['attributes']['location']),
      email: json['attributes']['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "id": id,
        "attributes": {
          "title": title,
          "address": address,
          "imagePath": imagePath,
          "phone": phone,
          "description": description,
          "location": location.toJson(),
          "email": email,
        },
      }
    };
  }
}

class Location {
  final String lat;
  final String lng;

  Location({required this.lat, required this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'] as String,
      lng: json['lng'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lng": lng,
    };
  }
}
