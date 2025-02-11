import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../models/request.dart';
import '../repositories/request_repository.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final RequestRepository repository;

  RequestBloc({required this.repository}) : super(const RequestState()) {
    on<LoadRequests>(_onLoadRequests);
    on<SelectRequest>(_onSelectRequest);
  }

  Future<void> _onLoadRequests(
    LoadRequests event,
    Emitter<RequestState> emit,
  ) async {
    try {
      final requests = await repository.fetchRequests();
      emit(state.copyWith(requests: requests));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onSelectRequest(SelectRequest event, Emitter<RequestState> emit) {
    debugPrint(
        '_onSelectRequest event select request with id: ${event.requestId}');
    emit(state.copyWith(selectedRequestId: event.requestId));
  }
}
