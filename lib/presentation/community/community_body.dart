import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/community/bloc/commun%C3%ADty_state.dart';
import 'package:reconstructitapp/presentation/community/bloc/community_bloc.dart';
import 'package:reconstructitapp/presentation/community/local_components/community_request_entry.dart';

class CommunityBody extends StatelessWidget {
  const CommunityBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (context, state) {
        if (state is CommunityLoaded) {
          return ListView.separated(
            itemBuilder:
                (context, index) => CommunityRequestEntry(
                  viewModel: state.communityBodyViewModels[index],
                ),
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: state.communityBodyViewModels.length,
          );
        }
        else if(state is CommunityLoading || state is CommunityInitial){
          return Center(child: CircularProgressIndicator());
        } else{
          return Container();
        }
      },
    );
  }
}
