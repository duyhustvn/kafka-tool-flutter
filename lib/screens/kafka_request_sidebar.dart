import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kafka_tool/bloc/request_bloc.dart';

class KafkaRequestSidebar extends StatelessWidget {
  const KafkaRequestSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestBloc, RequestState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.requests.length,
          itemBuilder: (context, index) {
            final request = state.requests[index];
            final isSelected = request.id == state.selectedRequestId;
            return ListTile(
              title: Text(request.title),
              selected: isSelected,
              selectedTileColor:
                  ThemeData().highlightColor, // Text color when selected
              onTap: () {
                context.read<RequestBloc>().add(SelectRequest(request.id));
                // Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
