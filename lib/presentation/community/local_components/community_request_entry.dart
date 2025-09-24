import 'package:flutter/material.dart';
import 'package:reconstructitapp/components/app_shimmer_rectangular.dart';
import 'package:reconstructitapp/components/app_shimmer_round.dart';
import 'package:reconstructitapp/presentation/community/community_body_view_model.dart';

import '../../others_request_detail/others_request_detail_screen.dart';

/// Browsing entry to a community print request
/// Clickable to get to the CommunityRequestDetailScreen
class CommunityRequestEntry extends StatelessWidget {
  final CommunityBodyViewModel viewModel;

  const CommunityRequestEntry({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Column(
        children: [
          // Profile
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                ClipOval(
                  child:
                      viewModel.user != null
                          ? viewModel.user?.userProfilePictureUrl != null
                              ? Image.network(
                                viewModel.user!.userProfilePictureUrl!,
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
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    viewModel.user != null
                        ? Text(
                          "${viewModel.user!.firstName} ${viewModel.user!.lastName}",
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                        : AppShimmerRectangular(width: 100, height: 20),
                    viewModel.user != null
                        ? Text(
                          viewModel.user!.region,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        )
                        : AppShimmerRectangular(width: 100, height: 16),
                  ],
                ),
              ],
            ),
          ),
          // item
          Stack(
            children: [
              viewModel.images != null
                  ? Image.network(
                    viewModel.images![0].imageUrl,
                    width: width,
                    height: width,
                    fit: BoxFit.cover,
                  )
                  : AppShimmerRectangular(width: width, height: width),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xE6E2E0F9),
                  ),
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              viewModel.item.title,
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              viewModel.item.description,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      Row(
                        children: [
                          SizedBox(width: 10),
                          Container(
                            width: 1,
                            height: 50,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  "max.",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall?.copyWith(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                                Text(
                                  "${viewModel.communityPrintRequest.priceMax?.toStringAsFixed(2)}€",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleLarge?.copyWith(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    OthersRequestDetailScreen(communityBodyViewModel: viewModel),
          ),
        );
      },
    );
  }
}
