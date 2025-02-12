part of 'request_bloc.dart';

abstract class RequestEvent extends Equatable {
  const RequestEvent();
}

class LoadRequests extends RequestEvent {
  @override
  List<Object> get props => [];
}

class SelectRequest extends RequestEvent {
  final String requestId;
  const SelectRequest(this.requestId);

  @override
  List<Object> get props => [requestId];
}

// TODO: add 2 new event update request name and request content
class UpdateContentRequest extends RequestEvent {
  final Request updatedRequest;
  const UpdateContentRequest(this.updatedRequest);

  @override
  List<Object?> get props => [updatedRequest];
}
