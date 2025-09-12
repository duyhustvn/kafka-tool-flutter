part of 'broker_bloc.dart';

class BrokerState extends Equatable {
  final String? broker;
  final String? username;
  final String? password;
  final String? error;
  final bool isLoading;

  const BrokerState({
    this.broker,
    this.username,
    this.password,
    this.error,
    this.isLoading = false,
  });

  BrokerState copyWith({
    String? broker,
    String? username,
    String? password,
    String? error,
    bool? isLoading,
    bool clearError = false,
  }) {
    return BrokerState(
      broker: broker ?? this.broker,
      username: username ?? this.username,
      password: password ?? this.password,
      error: clearError ? null : (error ?? this.error),
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [broker, username, password, error, isLoading];
}
