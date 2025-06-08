import 'package:flutter/material.dart';
import 'package:reconstructitapp/presentation/community/community_body_view_model.dart';

class CommunityRequestEntry extends StatelessWidget {
  final CommunityBodyViewModel viewModel;
  const CommunityRequestEntry({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // Profile
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'assets/example_person.png',
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10,),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "${viewModel.user.firstName} ${viewModel.user.lastName}",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  viewModel.user.region,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],)

            ],
          ),
        ),
        // item
        Stack(
          children: [
            Image.asset("assets/example.png", width: width,height: width,fit: BoxFit.cover,),
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
                      child:   Column(

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
                          ),
                        ],
                      )),

                    Row(children: [
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
                              "${viewModel.communityPrintRequest.priceMax}€",
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
                    ],)

                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
