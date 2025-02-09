import '../models/request.dart';

class RequestRepository {
  Future<List<Request>> fetchRequests() async {
    // Implement actual API call
    await Future.delayed(const Duration(seconds: 1));
    return const [
      Request(
          id: '1',
          title: 'Item 1',
          topic: 'test',
          quantity: 1,
          type: 'test',
          message: 'hello 1'),
      Request(
          id: '2',
          title: 'Item 2',
          topic: 'test',
          quantity: 2,
          type: 'test',
          message: 'hello 2'),
    ];
  }
}
