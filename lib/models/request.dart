import 'package:equatable/equatable.dart';

class Request extends Equatable {
  final String id;
  final String title;
  final String topic;
  final int quantity;
  final String message;
  final String header;
  final String key;

  const Request({
    required this.id,
    required this.title,
    required this.topic,
    required this.quantity,
    required this.message,
    required this.header,
    required this.key,
  });

  // create Request instance from a JSON map
  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'],
      title: json['title'],
      topic: json['topic'],
      quantity: json['quantity'],
      message: json['message'],
      header: json['header'],
      key: json['key'],
    );
  }

  Request copyWith({
    String? id,
    String? title,
    String? topic,
    int? quantity,
    String? message,
    String? header,
    String? key,
  }) {
    return Request(
      id: id ?? this.id,
      title: title ?? this.title,
      topic: topic ?? this.topic,
      quantity: quantity ?? this.quantity,
      message: message ?? this.message,
      header: header ?? this.header,
      key: key ?? this.key,
    );
  }

  @override
  List<Object> get props => [id, title, topic, quantity, message, header, key];
}
