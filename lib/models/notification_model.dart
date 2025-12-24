class NotificationModel {
  final String id;
  final String message;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.message,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ,
      message: json['attributes']['message'],
      isRead: json['attributes']['isRead'],
    );
  }
}
