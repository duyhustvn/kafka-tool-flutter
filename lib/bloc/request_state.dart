part of 'request_bloc.dart';

class RequestState extends Equatable {
  final List<Request> requests;
  final String? selectedRequestId;
  final String? error;

  const RequestState({
    this.requests = const [],
    this.selectedRequestId,
    this.error,
  });

  Request? get selectedRequest => requests.firstWhereOrNull(
        (request) => request.id == selectedRequestId,
      );

  RequestState copyWith({
    List<Request>? requests,
    String? selectedRequestId,
    String? error,
  }) {
    return RequestState(
      requests: requests ?? this.requests,
      selectedRequestId: selectedRequestId ?? this.selectedRequestId,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [requests, selectedRequestId, error];
}
