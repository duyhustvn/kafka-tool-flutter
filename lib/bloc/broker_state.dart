part of 'broker_bloc.dart';

class BrokerState extends Equatable {
  final String? broker;
  final String? error;

  const BrokerState({this.broker, this.error});

  BrokerState copyWith({
    String? broker,
    String? error,
  }) {
    return BrokerState(
      broker: broker ?? this.broker,
      error: error ?? this.error,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [broker, error];
}
