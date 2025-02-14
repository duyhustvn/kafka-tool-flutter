import './request.dart';

class ListRequestAPIData {
  final List<Request> requests;

  const ListRequestAPIData({required this.requests});

  factory ListRequestAPIData.fromJson(Map<String, dynamic> json) {
    return ListRequestAPIData(
      requests: List<Request>.from(
          json['requests'].map((rq) => Request.fromJson(rq))),
    );
  }
}

class ListRequestAPIResponse {
  final String status;
  final String? msg;
  final ListRequestAPIData? data;

  const ListRequestAPIResponse({
    required this.status,
    this.msg,
    this.data,
  });

  factory ListRequestAPIResponse.fromJson(Map<String, dynamic> json) {
    return ListRequestAPIResponse(
      status: json['status'],
      msg: json['msg'],
      data: ListRequestAPIData.fromJson(json['data']),
    );
  }
}
