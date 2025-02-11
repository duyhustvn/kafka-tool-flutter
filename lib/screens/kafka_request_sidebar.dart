import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafka_tool/bloc/request_bloc.dart';

class KafkaRequestSidebar extends StatelessWidget {
  const KafkaRequestSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<RequestBloc, RequestState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.requests.length,
            itemBuilder: (context, index) {
              final request = state.requests[index];
              return ListTile(
                title: TextFormField(
                  initialValue: request.title,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  // onChanged: (newName) {
                  //   context.read<RequestBloc>().add(
                  //         UpdateRequestName(request.id, newName),
                  //       );
                  // },
                ),
                onTap: () {
                  debugPrint('select request with id: ${request.id}');
                  context.read<RequestBloc>().add(SelectRequest(request.id));
                  Navigator.pop(context);
                },
              );
            },
          );
        },
      ),
    );
  }
}
