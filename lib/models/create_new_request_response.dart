class CreateNewRequestAPIResponseData {
  final int newRequestId;

  const CreateNewRequestAPIResponseData({required this.newRequestId});

  factory CreateNewRequestAPIResponseData.fromJson(Map<String, dynamic> json) {
    return CreateNewRequestAPIResponseData(
      newRequestId: json['new_request_id'],
    );
  }
}

class CreateNewRequestAPIResponse {
  final String status;
  final String? msg;
  final CreateNewRequestAPIResponseData? data;

  const CreateNewRequestAPIResponse({
    required this.status,
    this.msg,
    this.data,
  });

  factory CreateNewRequestAPIResponse.fromJson(Map<String, dynamic> json) {
    return CreateNewRequestAPIResponse(
      status: json['status'],
      msg: json['msg'],
      data: CreateNewRequestAPIResponseData.fromJson(json['data']),
    );
  }
}
