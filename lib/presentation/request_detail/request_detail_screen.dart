import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/community/community_body_view_model.dart';
import 'package:reconstructitapp/presentation/request_detail/bloc/request_detail_bloc.dart';
import 'package:reconstructitapp/presentation/request_detail/request_detail_body.dart';

import '../../utils/dependencies.dart';
import 'bloc/request_detail_event.dart';

class CommunityRequestDetailScreen extends StatefulWidget {
  final CommunityBodyViewModel communityBodyViewModel;

  const CommunityRequestDetailScreen({super.key, required this.communityBodyViewModel});

  @override
  State<CommunityRequestDetailScreen> createState() => _CommunityRequestDetailScreenState();
}

class _CommunityRequestDetailScreenState extends State<CommunityRequestDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  ic<RequestDetailBloc>()..add(
                    RequestDetailRefresh(
                      widget.communityBodyViewModel.communityPrintRequest.id!,
                    ),
                  ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(widget.communityBodyViewModel.item.title)),
        body: RequestDetailBody(
          communityBodyViewModel: widget.communityBodyViewModel,
        ),
      ),
    );
  }
}
