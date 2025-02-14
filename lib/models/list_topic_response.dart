class ListTopicAPIData {
  final List<String> topics;

  const ListTopicAPIData({required this.topics});

  factory ListTopicAPIData.fromJson(Map<String, dynamic> json) {
    List<String> topics = List<String>.from(json['topics']);
    return ListTopicAPIData(topics: topics);
  }

  Map<String, dynamic> toJson() => {"topics": topics};
}

class ListTopicAPIResponse {
  final String status;
  final String? msg;
  final ListTopicAPIData? data;

  const ListTopicAPIResponse({
    required this.status,
    this.data,
    this.msg,
  });

  factory ListTopicAPIResponse.fromJson(Map<String, dynamic> json) {
    return ListTopicAPIResponse(
      status: json['status'],
      data: ListTopicAPIData.fromJson(json['data']),
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'status': status, 'data': data?.toJson(), 'msg': msg};
}
