import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entity_models/enums/repair_status.dart';
import '../create_or_edit_request/request_detail_screen.dart';
import 'bloc/your_items_bloc.dart';
import 'bloc/yout_items_state.dart';

class YourRequestsBody extends StatelessWidget {
  const YourRequestsBody({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    YourRequestsBodyViewModel vm = YourRequestsBodyViewModel(
      null,
      null,
      Item(
        "7",
        RepairStatus.broken,
        "Autoteil",
        "Mein geliebtes Autoteil ist letzte Woche kaputt gegange, kann mir jemand helfen?",
        "",
        "meineid",
        "3",
      ),
      [],
    );
    YourRequestsBodyViewModel vm2 = YourRequestsBodyViewModel(
      [
        Chat("1", ChatStatus.done, "1", null, null),
        Chat("2", ChatStatus.done, "1", null, null),
      ],
      CommunityPrintRequest("1", 20, "1"),
      Item(
        "7",
        RepairStatus.fixed,
        "Musikanlage",
        "Mein geliebtes Musikanlage ist letzte Woche kaputt gegange, kann mir jemand helfen?",
        "",
        "meineid",
        "3",
      ),
      [],
    );
    List<YourRequestsBodyViewModel> state.yourRequestsBodyViewModel = [vm, vm2];
    
     */

    return BlocBuilder<YourItemsBloc, YourItemsState>(
      builder: (context, state) {
        if (state is YourItemsLoading || state is YourItemsInitial) {
          return CircularProgressIndicator();
        }
        if (state is YourItemsLoaded) {
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
                      child:state.yourRequestsBodyViewModel[index].images!= null && state.yourRequestsBodyViewModel[index].images!.isNotEmpty? Image.network(
                        state.yourRequestsBodyViewModel[index].images![0].imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ):Image.asset(
                       "assets/example.png",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 5.0,
                          children: [
                            state
                                        .yourRequestsBodyViewModel[index]
                                        .communityPrintRequest ==
                                    null
                                ? Text(
                                  "Privat",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelSmall?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                )
                                : Text(
                                  state
                                              .yourRequestsBodyViewModel[index]
                                              .chats !=
                                          null
                                      ? "${state.yourRequestsBodyViewModel[index].chats?.length} Chats"
                                      : "0 Chats",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelSmall?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
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
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                          ],
                        ),
                        Text(
                          state.yourRequestsBodyViewModel[index].item.title,
                          style: Theme.of(context).textTheme.titleMedium,
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
        }
        return Container(child: Text("failed"),);
      },
    );
  }
}
