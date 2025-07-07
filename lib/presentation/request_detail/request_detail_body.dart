import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/components/AppButton.dart';
import 'package:reconstructitapp/components/AppIconButton.dart';
import 'package:reconstructitapp/presentation/community/community_body_view_model.dart';
import 'package:reconstructitapp/presentation/request_detail/bloc/request_detail_bloc.dart';
import 'package:reconstructitapp/presentation/request_detail/bloc/request_detail_state.dart';
import 'package:reconstructitapp/presentation/request_detail/create_chat_bloc/create_chat_bloc.dart';
import 'package:reconstructitapp/presentation/request_detail/create_chat_bloc/create_chat_event.dart';

import '../../components/AppShimmerRectangular.dart';
import '../../components/AppShimmerRound.dart';

class RequestDetailBody extends StatelessWidget {
  final CommunityBodyViewModel communityBodyViewModel;

  const RequestDetailBody({super.key, required this.communityBodyViewModel});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              communityBodyViewModel.image != null
                  ? Image.network(
                    communityBodyViewModel.image!.imageUrl,
                    width: width,
                    height: width,
                    fit: BoxFit.cover,
                  )
                  : AppShimmerRectangular(width: width, height: width),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      spacing: 15.0,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            spacing: 10,
                            children: [
                              ClipOval(
                                child:
                                    communityBodyViewModel.user != null
                                        ? communityBodyViewModel
                                                    .user
                                                    ?.userProfilePictureUrl !=
                                                null
                                            ? Image.network(
                                              communityBodyViewModel
                                                  .user!
                                                  .userProfilePictureUrl!,
                                              width: 32,
                                              height: 32,
                                              fit: BoxFit.cover,
                                            )
                                            : Image.asset(
                                              "assets/round_avatar_placeholder.jpg",
                                              width: 32,
                                              height: 32,
                                              fit: BoxFit.cover,
                                            )
                                        : AppShimmerRound(size: 32),
                              ),
                              Column(
                                children: [
                                  communityBodyViewModel.user != null
                                      ? Text(
                                        "${communityBodyViewModel.user!.firstName} ${communityBodyViewModel.user!.lastName}",
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.titleSmall,
                                      )
                                      : AppShimmerRectangular(
                                        width: 100,
                                        height: 20,
                                      ),
                                  communityBodyViewModel.user != null
                                      ? Text(
                                        communityBodyViewModel.user!.region,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.copyWith(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.onSurfaceVariant,
                                        ),
                                      )
                                      : AppShimmerRectangular(
                                        width: 100,
                                        height: 16,
                                      ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Mit dieser\nAnfrage kannst\ndu max. ${communityBodyViewModel.communityPrintRequest.priceMax}\nverdienen",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "CAD\nherunterladen",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              AppIconButton(
                                icon: Icon(Icons.arrow_circle_down),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            communityBodyViewModel.item.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            communityBodyViewModel.item.description,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<RequestDetailBloc, RequestDetailState>(
          buildWhen: (prev, curr) => curr is RequestDetailLoaded,
          builder: (context, state) {
            if (state is RequestDetailLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  state.alreadyHasChat
                      ? AppButton(
                        child: Row(
                          children: [
                            Icon(Icons.maps_ugc_outlined),
                            Text("Zum Chat"),
                          ],
                        ),
                      )
                      : AppButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 15,
                          children: [
                            Icon(Icons.maps_ugc_outlined),
                            Text("Chat erstellen"),
                          ],
                        ),
                        onPressed: () {
                          context.read<CreateChatBloc>().add(
                            CreateChat(
                              communityBodyViewModel.communityPrintRequest.id!,
                              communityBodyViewModel.user!.id!,
                            ),
                          );
                        },
                      ),
                ],
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
