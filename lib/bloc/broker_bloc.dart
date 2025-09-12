import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafka_tool/repositories/broker_repository.dart';
import 'package:kafka_tool/models/broker.dart';

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
    // Emit loading state and clear any previous errors
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      Broker broker = event.broker;
      await repository.connectKafkaBrokers(
        broker.broker_url,
        broker.username,
        broker.password,
      );
      emit(
        state.copyWith(
          broker: broker.broker_url,
          username: broker.username,
          password: broker.password,
          isLoading: false,
          clearError: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }
}
