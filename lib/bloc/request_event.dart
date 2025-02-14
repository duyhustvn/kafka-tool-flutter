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

class UpdateContentRequest extends RequestEvent {
  final Request updatedRequest;
  const UpdateContentRequest(this.updatedRequest);

  @override
  List<Object?> get props => [updatedRequest];
}

class CreateRequest extends RequestEvent {
  final Request newRequest;
  const CreateRequest(this.newRequest);

  @override
  List<Object?> get props => [newRequest];
}

class DeleteRequestEvent extends RequestEvent {
  final int requestId;
  const DeleteRequestEvent(this.requestId);

  @override
  List<Object?> get props => [requestId];
}
