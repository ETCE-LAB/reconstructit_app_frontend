import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/create_or_edit_request/create_request/create_request_screen.dart';
import 'package:reconstructitapp/presentation/your_items/your_items_body.dart';

import '../../utils/dependencies.dart';
import 'bloc/your_items_bloc.dart';
import 'bloc/your_items_event.dart';

/// Top level screen to get all own items
class YourItemsScreen extends StatefulWidget {
  const YourItemsScreen({super.key});

  @override
  State<YourItemsScreen> createState() => _YourItemsScreenState();
}

class _YourItemsScreenState extends State<YourItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ic<YourItemsBloc>()..add(RefreshItems()),
      child: YourRequestsScaffold(),
    );
  }
}

class YourRequestsScaffold extends StatelessWidget {
  const YourRequestsScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Deine Reperaturobjekte"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRequestScreen()),
          );
          if (context.mounted) {
            context.read<YourItemsBloc>().add(RefreshItems());
          }
        },
        child: const Icon(Icons.add),
      ),
      body: YourItemsBody(),
    );
  }
}
