import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/community/bloc/community_bloc.dart';
import 'package:reconstructitapp/presentation/community/community_body.dart';

import '../../utils/dependencies.dart';
import 'bloc/community_event.dart';

/// This Screen is a top level screen and is built with the navbar
/// Browsing Screen of community print requests of the community
class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ic<CommunityBloc>()..add(CommunityRefresh()),
      child: Scaffold(
        appBar: AppBar(title: Text("Communityanfragen"), centerTitle: true),
        body: CommunityBody(),
      ),
    );
  }
}
