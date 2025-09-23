import 'package:flutter/material.dart';
import 'package:reconstructitapp/components/app_shimmer_rectangular.dart';
import 'package:reconstructitapp/components/app_shimmer_round.dart';
import 'package:reconstructitapp/presentation/print_contract/print_contract_view_model.dart';

class PrintContractEntry extends StatelessWidget {
  final PrintContractViewModel printContractViewModel;

  const PrintContractEntry({super.key, required this.printContractViewModel});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        SizedBox(
          height: 50,
          width: 50,

          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child:
                    printContractViewModel.otherUser != null
                        ? ClipOval(
                          child:
                              printContractViewModel
                                          .otherUser!
                                          .userProfilePictureUrl !=
                                      null
                                  ? Image.network(
                                    printContractViewModel
                                        .otherUser!
                                        .userProfilePictureUrl!,
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.cover,
                                  )
                                  : Image.asset(
                                    "assets/round_avatar_placeholder.jpg",
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.cover,
                                  ),
                        )
                        : AppShimmerRound(size: 50),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child:
                    printContractViewModel.ownUser != null
                        ? ClipOval(
                          child:
                              printContractViewModel
                                          .ownUser!
                                          .userProfilePictureUrl !=
                                      null
                                  ? Image.network(
                                    printContractViewModel
                                        .ownUser!
                                        .userProfilePictureUrl!,
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.cover,
                                  )
                                  : Image.asset(
                                    "assets/landscape.png",
                                    width: 35,
                                    height: 35,
                                    fit: BoxFit.cover,
                                  ),
                        )
                        : AppShimmerRound(size: 35),
              ),
            ],
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      printContractViewModel.getLatestStatus() != null
                          ? Text(
                            printContractViewModel.getLatestStatus()!,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: Color(0xFF003250)),
                          )
                          : AppShimmerRectangular(width: 100, height: 15),

                      Text(
                        "${printContractViewModel.otherUser?.firstName} - ${printContractViewModel.item?.title}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
