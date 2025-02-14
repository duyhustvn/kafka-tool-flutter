import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:kafka_tool/models/create_new_request_response.dart';

import '../models/request.dart';
import '../repositories/request_repository.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final RequestRepository repository;

  RequestBloc({required this.repository}) : super(const RequestState()) {
    on<LoadRequests>(_onLoadRequests);
    on<SelectRequest>(_onSelectRequest);
    on<UpdateContentRequest>(_onUpdateRequest);
    on<CreateRequest>(_onCreateRequest);
  }

  Future<void> _onLoadRequests(
    LoadRequests event,
    Emitter<RequestState> emit,
  ) async {
    try {
      final requests = await repository.fetchRequests();
      debugPrint("emit load request");
      emit(state.copyWith(requests: requests.data?.requests));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  void _onSelectRequest(SelectRequest event, Emitter<RequestState> emit) {
    emit(state.copyWith(selectedRequestId: event.requestId));
  }

  Future<void> _onUpdateRequest(
    UpdateContentRequest event,
    Emitter<RequestState> emit,
  ) async {
    try {
      await repository.updateRequest(event.updatedRequest);

      final updateRequests = state.requests.map((request) {
        return request.id == event.updatedRequest.id
            ? event.updatedRequest
            : request;
      }).toList();

      emit(state.copyWith(requests: updateRequests));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> _onCreateRequest(
    CreateRequest event,
    Emitter<RequestState> emit,
  ) async {
    try {
      Request newRequest = event.newRequest;
      CreateNewRequestAPIResponse res = await repository.createRequest(
        newRequest.title,
        newRequest.topic,
        newRequest.quantity,
        newRequest.message,
      );
      String newRequestId = res.data!.newRequestId.toString();

      Request newlyCreatedRequest = newRequest.copyWith(
        id: newRequestId,
        title: newRequest.title,
        topic: newRequest.topic,
        quantity: newRequest.quantity,
        message: newRequest.message,
      );
      final newRequests = [...state.requests, newlyCreatedRequest];
      emit(state.copyWith(requests: newRequests));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}
