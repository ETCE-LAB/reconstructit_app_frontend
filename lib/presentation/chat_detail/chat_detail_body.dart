import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reconstructitapp/components/AppIconButton.dart';
import 'package:reconstructitapp/components/AppTextField.dart';
import 'package:reconstructitapp/domain/entity_models/message.dart';
import 'package:reconstructitapp/presentation/chat/chat_body_view_model.dart';
import 'package:reconstructitapp/presentation/chat_detail/message_widget.dart';

class ChatDetailBody extends StatefulWidget {
  final ChatBodyViewModel chatBodyViewModel;

  const ChatDetailBody({super.key, required this.chatBodyViewModel});

  @override
  State<ChatDetailBody> createState() => _ChatDetailBodyState();
}

class _ChatDetailBodyState extends State<ChatDetailBody> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // list of messages
    Message message1 = Message(
      "1",
      "Hey!  Ich würde dir gerne helfen, ich mach dir das auch umsonst",
      DateTime.now().subtract(Duration(days: 1)),
      "ownParticipantId",
      "2",
    );
    Message message2 = Message(
      "2",
      "Hallo, das ist ja superlieb, ich danke dir!",
      DateTime.now(),
      "otherParticipantId",
      "2",
    );
    Message message3 = Message(
      "3",
      "Mathilda hat ihre/seine Adresse mit dir geteilt.  Du kannst nun Mathildas Adresse  auf dem Body dieser Anfrage einsehen.",
      DateTime.now(),
      null,
      "2",
    );

    List<Message> messages = [message1, message2, message3];
    void sendMessage() {
      final text = _controller.text.trim();
      if (text.isEmpty) return;

      setState(() {
        messages.add(
          Message(
            "bla",
            text,
            DateTime.now(),
            widget.chatBodyViewModel.ownParticipant.id,
            "4",
          ),
        );
      });
      _controller.clear();
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.all(15),
            itemCount: messages.length,
            separatorBuilder: (context, index) => SizedBox(height: 15),
            itemBuilder: (context, index) {
              final current = messages[index];
              final previous = index > 0 ? messages[index - 1] : null;

              bool showDate = false;
              if (previous == null ||
                  !isSameDay(previous.sentAt, current.sentAt)) {
                showDate = true;
              }

              return Column(
                children: [
                  if (showDate)
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            DateFormat('dd.MM.yyyy').format(current.sentAt),
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ),
                  MessageWidget(
                    message: messages[index],
                    ownParticipantId:
                        widget.chatBodyViewModel.ownParticipant.id!,
                  ),
                ],
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: AppTextField(
            hint: "Neue Nachricht",
            controller: _controller,
            trailing: AppIconButton(icon: Icon(Icons.send, size: 20,), onPressed: sendMessage,),
          ),
        ),
      ],
    );
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
