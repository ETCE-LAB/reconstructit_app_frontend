import 'package:flutter/material.dart';
import 'package:reconstructitapp/presentation/chat/chat_body_view_model.dart';
import 'package:reconstructitapp/presentation/chat_detail/chat_detail_body.dart';
import 'package:reconstructitapp/presentation/chat_detail/select_status_bottom_sheet.dart';

class ChatDetailScreen extends StatefulWidget {
  final ChatBodyViewModel chatBodyViewModel;

  const ChatDetailScreen({super.key, required this.chatBodyViewModel});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                builder: (_) => SelectStatusBottomSheet(),
              );
            },
            child: Icon(Icons.more_vert),
          ),
          SizedBox(width: 10),
        ],
        title: ListTile(
          leading: SizedBox(
            height: 50,
            width: 50,

            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/example_person.png',
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/example.png',
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: Text("lol"
            /*
            widget.chatBodyViewModel.getStatus(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: widget.chatBodyViewModel.getStatusColor(),
            ),

             */
          ),
          subtitle: Text(
            "${widget.chatBodyViewModel.otherParticipantUser.firstName} ${widget.chatBodyViewModel.otherParticipantUser.lastName} - ${widget.chatBodyViewModel.item.title}",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
      body: ChatDetailBody(chatBodyViewModel: widget.chatBodyViewModel),
    );
  }
}
