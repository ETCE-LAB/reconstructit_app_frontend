import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/components/app_shimmer_round.dart';

import '../../domain/entity_models/enums/repair_status.dart';
import '../create_or_edit_request/request_detail_screen.dart';
import 'bloc/your_items_bloc.dart';
import 'bloc/yout_items_state.dart';

class YourRequestsBody extends StatelessWidget {
  const YourRequestsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<YourItemsBloc, YourItemsState>(
      builder: (context, state) {
        if (state is YourItemsLoading || state is YourItemsInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is YourItemsLoaded) {
          if (state.yourRequestsBodyViewModel.isNotEmpty) {
            return ListView.separated(
              padding: EdgeInsets.all(15),
              itemBuilder:
                  (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => RequestDetailScreen(
                                requestsBodyViewModel:
                                    state.yourRequestsBodyViewModel[index],
                              ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: ClipOval(
                        child:
                            state.yourRequestsBodyViewModel[index].images !=
                                        null &&
                                    state
                                        .yourRequestsBodyViewModel[index]
                                        .images!
                                        .isNotEmpty
                                ? Image.network(
                                  state
                                      .yourRequestsBodyViewModel[index]
                                      .images![0]
                                      .imageUrl,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                                : AppShimmerRound(size: 50),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 5.0,
                            children: [
                              if (state
                                      .yourRequestsBodyViewModel[index]
                                      .item
                                      .status ==
                                  RepairStatus.fixed)
                                Text(
                                  "Repariert",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelSmall?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                            ],
                          ),
                          Text(
                            state.yourRequestsBodyViewModel[index].item.title,
                            style: Theme.of(context).textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                      subtitle: Text(
                        state.yourRequestsBodyViewModel[index].item.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: state.yourRequestsBodyViewModel.length,
            );
          } else {
            // no items yet
            return Padding(
              padding: EdgeInsets.all(15),
              child: Text("Ganz schön leer hier..."),
            );
          }
        }
        return Text("failed");
      },
    );
  }
}
