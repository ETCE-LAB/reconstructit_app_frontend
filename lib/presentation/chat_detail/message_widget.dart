import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entity_models/message.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  final String ownParticipantId;
  const MessageWidget({super.key, required this.message, required this.ownParticipantId});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
   if (message.participantId == null) {
      return Center(
        child: Container(

          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(

            message.content,
            textAlign: TextAlign.center,
            style:   Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          ),
        ),
      );
    }

    bool isOwn = message.participantId == ownParticipantId;

    return Align(
      alignment: isOwn ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(10),
        constraints: BoxConstraints(maxWidth: width*0.8),
        decoration: BoxDecoration(
          color: isOwn ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message.content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isOwn ? Theme.of(context).colorScheme.onTertiary : Theme.of(context).colorScheme.onTertiaryContainer,
        ),
        ),
      ),
    );

}
}
