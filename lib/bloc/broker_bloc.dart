import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafka_tool/repositories/broker_repository.dart';

part 'broker_event.dart';
part 'broker_state.dart';

class BrokerBloc extends Bloc<BrokerEvent, BrokerState> {
  final BrokerRepository repository;

  BrokerBloc({required this.repository}) : super(const BrokerState()) {
    on<ConnectBroker>(_onConnectBroker);
  }

  Future<void> _onConnectBroker(
    ConnectBroker event,
    Emitter<BrokerState> emit,
  ) async {
    try {
      await repository.connectKafkaBrokers(event.broker);
      emit(state.copyWith(broker: event.broker));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
