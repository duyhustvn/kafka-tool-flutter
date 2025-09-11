part of 'broker_bloc.dart';

abstract class BrokerEvent extends Equatable {
  const BrokerEvent();
}

class ConnectBroker extends BrokerEvent {
  final Broker broker;
  const ConnectBroker(this.broker);

  @override
  List<Object?> get props => [broker];
}
