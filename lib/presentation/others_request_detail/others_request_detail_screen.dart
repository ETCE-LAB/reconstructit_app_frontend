import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/community/community_body_view_model.dart';
import 'package:reconstructitapp/presentation/others_request_detail/bloc/others_request_detail_bloc.dart';
import '../../utils/dependencies.dart';
import 'bloc/others_request_detail_event.dart';
import 'others_request_detail_body.dart';

/// Shows a communnity request from a other user
class OthersRequestDetailScreen extends StatefulWidget {
  final CommunityBodyViewModel communityBodyViewModel;

  const OthersRequestDetailScreen({
    super.key,
    required this.communityBodyViewModel,
  });

  @override
  State<OthersRequestDetailScreen> createState() =>
      _OthersRequestDetailScreenState();
}

class _OthersRequestDetailScreenState
    extends State<OthersRequestDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  ic<OthersRequestDetailBloc>()..add(
                    OthersRequestDetailRefresh(
                      widget.communityBodyViewModel.communityPrintRequest.id!,
                    ),
                  ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(widget.communityBodyViewModel.item.title)),
        body: OthersRequestDetailBody(
          communityBodyViewModel: widget.communityBodyViewModel,
        ),
      ),
    );
  }
}
