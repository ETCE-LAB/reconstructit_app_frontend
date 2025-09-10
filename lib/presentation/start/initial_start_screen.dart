import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/start/initial_start_body.dart';

import '../../utils/dependencies.dart';
import 'bloc/initial_bloc.dart';
import 'bloc/initial_event.dart';

class InitialStartScreen extends StatefulWidget {
  const InitialStartScreen({super.key});

  @override
  State<InitialStartScreen> createState() => _InitialStartScreenState();
}

class _InitialStartScreenState extends State<InitialStartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ic<InitialBloc>()..add(AlreadyInitialedRequested()),
      child: InitialStartBody(),
    );
  }
}
