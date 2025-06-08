import 'package:flutter/cupertino.dart';
import 'package:reconstructitapp/presentation/community/community_body_view_model.dart';
import 'package:reconstructitapp/presentation/community/local_components/community_request_entry.dart';

import '../../domain/entity_models/community_print_request.dart';
import '../../domain/entity_models/enums/repair_status.dart';
import '../../domain/entity_models/item.dart';
import '../../domain/entity_models/user.dart';

class CommunityBody extends StatelessWidget {
  const CommunityBody({super.key});

  @override
  Widget build(BuildContext context) {
    CommunityBodyViewModel vm = CommunityBodyViewModel(
      User("1", "mathilda", "Schulz", "hannover", "url", null, null),
      CommunityPrintRequest("3", 500, "7"),
      Item(
        "7",
        RepairStatus.broken,
        "Autoteil",
        "Mein geliebtes Autoteil ist letzte Woche kaputt gegange, kann mir jemand helfen?",
        "",
        "meineid",
        "3",
      ),
    );
    CommunityBodyViewModel vm2 = CommunityBodyViewModel(
      User("1", "Maximilian", "Flügel", "Wernigerrode", "url", null, null),
      CommunityPrintRequest("4", 10, "8"),
      Item("8", RepairStatus.broken, "Lampe", "Hilfi", "", "meineid", "4"),
    );

    List<CommunityBodyViewModel> list = [vm, vm2];
    return ListView.separated(
      itemBuilder: (context, index) => CommunityRequestEntry(viewModel: list[index],),
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemCount: list.length,
    );
  }
}
