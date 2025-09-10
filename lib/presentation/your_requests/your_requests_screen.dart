import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/create_or_edit_request/create_request/create_request_screen.dart';
import 'package:reconstructitapp/presentation/your_requests/bloc/your_items_bloc.dart';
import 'package:reconstructitapp/presentation/your_requests/bloc/your_items_event.dart';
import 'package:reconstructitapp/presentation/your_requests/your_requests_body.dart';

import '../../utils/dependencies.dart';

class YourRequestsScreen extends StatefulWidget {
  const YourRequestsScreen({super.key});

  @override
  State<YourRequestsScreen> createState() => _YourRequestsScreenState();
}

class _YourRequestsScreenState extends State<YourRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ic<YourItemsBloc>()..add(Refresh()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Deine Reperaturobjekte"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateRequestScreen()),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: YourRequestsBody(),
      ),
    );
  }
}
