import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/components/app_button.dart';
import 'package:reconstructitapp/components/app_icon_button.dart';
import 'package:reconstructitapp/presentation/choose_payment_method/choose_payment_bottom_sheet.dart';
import 'package:reconstructitapp/presentation/community/community_body_view_model.dart';
import 'package:reconstructitapp/presentation/request_detail/bloc/request_detail_bloc.dart';
import 'package:reconstructitapp/presentation/request_detail/bloc/request_detail_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/app_shimmer_rectangular.dart';
import '../../components/app_shimmer_round.dart';
import '../print_contract/print_contract_screen.dart';

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
              communityBodyViewModel.images != null
                  ? Image.network(
                    communityBodyViewModel.images![0].imageUrl,
                    width: width,
                    height: width,
                    fit: BoxFit.cover,
                  )
                  : AppShimmerRectangular(width: width, height: width),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  spacing: 15,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 15.0,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
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
                                            textAlign: TextAlign.center,
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
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .onSurfaceVariant,
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
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Mit dieser\nAnfrage kannst\ndu max. ${communityBodyViewModel.communityPrintRequest.priceMax?.toStringAsFixed(2)}€\nverdienen",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // width: (width - 60) / 3,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Modell\nherunterladen",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  if (communityBodyViewModel.constructionFile !=
                                      null)
                                    AppIconButton(
                                      icon: Icon(Icons.arrow_circle_down),
                                      onPressed: () async {
                                        await launchUrl(
                                          Uri.parse(
                                            communityBodyViewModel
                                                .constructionFile!
                                                .fileUrl,
                                          ),
                                          mode: LaunchMode.externalApplication,
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  communityBodyViewModel.item.title,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
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
            ],
          ),
        ),
        if (communityBodyViewModel.user != null)
          BlocBuilder<RequestDetailBloc, RequestDetailState>(
            buildWhen: (prev, curr) => curr is RequestDetailLoaded,
            builder: (context, state) {
              if (state is RequestDetailLoaded) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    state.printContractId != null
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppButton(
                              // navigate to process
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => PrintContractScreen(
                                          printContractId:
                                              state.printContractId!,
                                        ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                spacing: 15,
                                children: [
                                  Icon(Icons.maps_ugc_outlined),
                                  Text("Zum Vorgang"),
                                ],
                              ),
                            ),
                          ],
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                spacing: 15,
                                children: [
                                  Icon(Icons.maps_ugc_outlined),
                                  Text(
                                    "Für ${communityBodyViewModel.communityPrintRequest.priceMax?.toStringAsFixed(2)}€ Druck anbieten",
                                  ),
                                ],
                              ),

                              onPressed: () {
                                showModalBottomSheet(
                                  showDragHandle: true,
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(40),
                                    ),
                                  ),
                                  builder:
                                      (_) => ChoosePaymentBottomSheet(
                                        otherUser: communityBodyViewModel.user!,
                                        communityPrintRequestId:
                                            communityBodyViewModel
                                                .communityPrintRequest
                                                .id!,
                                      ),
                                );
                                /*
                          context.read<CreatePrintContractBloc>().add(
                            CreatePrintContract(
                              communityBodyViewModel.communityPrintRequest.id!,
                              communityBodyViewModel.user!.id!,
                            ),
                          );

                           */
                              },
                            ),
                          ],
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
