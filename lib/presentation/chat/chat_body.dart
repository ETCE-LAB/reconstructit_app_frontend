import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reconstructitapp/components/AppTextField.dart';
import 'package:reconstructitapp/domain/entity_models/community_print_request.dart';
import 'package:reconstructitapp/domain/entity_models/enums/chat_status.dart';
import 'package:reconstructitapp/domain/entity_models/enums/participant_role.dart';
import 'package:reconstructitapp/domain/entity_models/enums/repair_status.dart';
import 'package:reconstructitapp/domain/entity_models/message.dart';
import 'package:reconstructitapp/domain/entity_models/participant.dart';
import 'package:reconstructitapp/presentation/chat/chat_body_view_model.dart';
import 'package:reconstructitapp/presentation/chat/chat_entry.dart';
import 'package:reconstructitapp/presentation/chat_detail/chat_detail_screen.dart';

import '../../domain/entity_models/chat.dart';
import '../../domain/entity_models/item.dart';
import '../../domain/entity_models/user.dart';

class ChatBody extends StatefulWidget {
  const ChatBody({super.key});

  @override
  State<ChatBody> createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  ChatBodyViewModel vm = ChatBodyViewModel(
    User("1", "mathilda", "Schulz", "hannover", "url", null, null),
    Chat("2", ChatStatus.done, "3", "4", null),
    Message("4", "Hey, ja das mache ich", DateTime.now(), "6", "2"),
    CommunityPrintRequest("3", 500, "7"),
    Item(
      "7",
      RepairStatus.broken,
      "Autoteil",
      "Beschreinung",
      "",
      "meineid",
      "3",
    ),
    Participant("ownParticipantId", ParticipantRole.helpProvider, "4", "2"),
    Participant("otherParticipantId", ParticipantRole.helpReceiver, "1", "2"),
  );

  @override
  Widget build(BuildContext context) {


    final List<ChatBodyViewModel> list = [vm, vm];
    return Scaffold(
      appBar: AppBar(title: Text("Chats"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(hint: "Suche nach Namen oder Titel..."),
            SizedBox(height: 20),
            ListView.separated(
              itemCount: list.length,
              shrinkWrap: true,

              itemBuilder:
                  (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ChatDetailScreen(
                                chatBodyViewModel: list[index],
                              ),
                        ),
                      );
                    },
                    child: ChatEntry(chatBodyViewModel: list[index])
                  ),
              separatorBuilder:
                  (BuildContext context, int index) => SizedBox(height: 15),
            ),
          ],
        ),
      ),
    );
  }
}
