import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const TabBarExample(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kafka Tool'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Publish',
              ),
              Tab(
                text: 'Subscribe',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            const BuildPublishWidget(),
            const Center(
              child: Text(""),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildPublishWidget extends StatefulWidget {
  const BuildPublishWidget({super.key});

  @override
  State<BuildPublishWidget> createState() => _BuildPublishWidgetState();
}

class _BuildPublishWidgetState extends State<BuildPublishWidget> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          maxLines: 20,
          controller: myController,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            print("Text: ${myController.text}");
          },
          child: const Text("Publish"),
        )
      ],
    );
  }
}
