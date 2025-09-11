import 'package:equatable/equatable.dart';

class Broker extends Equatable {
  final String broker_url;
  final String username;
  final String password;

  const Broker({
    required this.broker_url,
    required this.username,
    required this.password,
  });

  // create Broker instance from a JSON map
  factory Broker.fromJson(Map<String, dynamic> json) {
    return Broker(
      broker_url: json['broker_url'],
      username: json['username'],
      password: json['password'],
    );
  }

  Broker copyWith({String? broker_url, String? username, String? password}) {
    return Broker(
      broker_url: broker_url ?? this.broker_url,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [broker_url, username, password];
}
