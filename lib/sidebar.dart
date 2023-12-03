import 'package:flutter/material.dart';

// API
import 'package:kafka_tool/api/request_list_api.dart';

class Sidebar extends StatelessWidget {
  Future<List<String>> _listRequests() async {
    try {
      List<String> requestsTitle = [];
      final res = await listRequests();
      for (var request in res.data!.requests) {
        requestsTitle.add(request.title);
      }
      return requestsTitle;
    } catch (e) {
      // print("Error loading requests: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder(
        future: _listRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No data available');
          } else {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    'Sidebar Header',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ExpansionTile(
                  title: const Text('Foldable Options 1'),
                  children: [
                    for (String item in snapshot.data!)
                      ListTile(
                        title: Text(item),
                        onTap: () {},
                      ),
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }
}
