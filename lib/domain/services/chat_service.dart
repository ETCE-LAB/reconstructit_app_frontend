import 'dart:async';

import '../../utils/result.dart';
import '../entity_models/chat.dart';

abstract class ChatService {
  Future<Result<Chat>> getChat(String id);

  Future<Result<List<Chat>>> getChatsForCommunityPrintRequest(String id);

  Future<Result<Chat>> createChat(Chat chat);

  Future<Result<void>> updateChat(Chat chat);
}
