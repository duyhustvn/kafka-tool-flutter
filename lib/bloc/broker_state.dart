part of 'broker_bloc.dart';

class BrokerState extends Equatable {
  final String? broker;
  final String? username;
  final String? password;
  final String? error;

  const BrokerState({this.broker, this.username, this.password, this.error});

  BrokerState copyWith({
    String? broker,
    String? username,
    String? password,
    String? error,
  }) {
    return BrokerState(
      broker: broker ?? this.broker,
      username: username ?? this.username,
      password: password ?? this.password,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [broker, username, password, error];
}
