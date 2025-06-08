import '../../domain/entity_models/message.dart';
import '../../domain/services/message_service.dart';
import '../../utils/result.dart';
import '../sources/remote_datasource.dart';

class MessageRepository implements MessageService {
  final IRemoteDatasource remoteDatasource;
  MessageRepository(this.remoteDatasource);

  @override
  Future<Result<List<Message>>> getMessagesForChat(String chatId) async {
    try {
      return Result.success(await remoteDatasource.getMessagesByChatId(chatId));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<Message>> getMessage(String id) async {
    try {
      return Result.success(await remoteDatasource.getMessage(id));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<Message>> createMessage(Message message) async {
    try {
      return Result.success(await remoteDatasource.createMessage(message));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
}