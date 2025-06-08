import 'dart:async';

import '../../utils/result.dart';
import '../entity_models/message.dart';

abstract class MessageService {
  Future<Result<List<Message>>> getMessagesForChat(String chatId);

  Future<Result<Message>> getMessage(String id);

  Future<Result<Message>> createMessage(Message message);
}
