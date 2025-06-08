import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reconstructitapp/presentation/chat/chat_body_view_model.dart';

class ChatEntry extends StatelessWidget {
  final ChatBodyViewModel chatBodyViewModel;

  const ChatEntry({super.key, required this.chatBodyViewModel});

  @override
  Widget build(BuildContext context) {
    String formatDateTime(DateTime input) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(Duration(days: 1));
      final inputDate = DateTime(input.year, input.month, input.day);

      final timeFormat = DateFormat('HH:mm');

      if (inputDate == today) {
        // Heute
        return timeFormat.format(input);
      } else if (inputDate == yesterday) {
        // Gestern
        return 'Gestern, ${timeFormat.format(input)}';
      } else {
        // Anderes Datum
        final fullFormat = DateFormat('dd.MM.yyyy, HH:mm');
        return fullFormat.format(input);
      }
    }

    return Row(
      children: [
        SizedBox(
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
                      Text(
                        chatBodyViewModel.getStatus(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: chatBodyViewModel.getStatusColor(),
                        ),
                      ),
                      Text(
                        "${chatBodyViewModel.otherParticipantUser.firstName} ${chatBodyViewModel.otherParticipantUser.lastName} - ${chatBodyViewModel.item.title}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Text(
                    formatDateTime(chatBodyViewModel.lastMessage.sentAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Text(
                chatBodyViewModel.lastMessage.content,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
