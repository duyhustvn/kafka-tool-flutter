import 'package:equatable/equatable.dart';

class Request extends Equatable {
  final String id;
  final String title;
  final String topic;
  final int quantity;
  final String message;

  const Request(
      {required this.id,
      required this.title,
      required this.topic,
      required this.quantity,
      required this.message});

  // create Request instance from a JSON map
  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
        id: json['id'],
        title: json['title'],
        topic: json['topic'],
        quantity: json['quantity'],
        message: json['message']);
  }

  Request copyWith(
      {String? id,
      String? title,
      String? topic,
      int? quantity,
      String? message}) {
    return Request(
      id: id ?? this.id,
      title: title ?? this.title,
      topic: topic ?? this.topic,
      quantity: quantity ?? this.quantity,
      message: message ?? this.message,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [id, title, topic, quantity, message];
}
