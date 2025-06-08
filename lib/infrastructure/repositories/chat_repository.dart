import '../../domain/entity_models/chat.dart';
import '../../domain/services/chat_service.dart';
import '../../utils/result.dart';
import '../sources/remote_datasource.dart';


class ChatRepository implements ChatService {
  final IRemoteDatasource remoteDatasource;
  ChatRepository(this.remoteDatasource);

  @override
  Future<Result<Chat>> getChat(String id) async {
    try {
      return Result.success(await remoteDatasource.getChat(id));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<Chat>> createChat(Chat chat) async {
    try {
      return Result.success(await remoteDatasource.createChat(chat));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<void>> updateChat(Chat chat) async {
    try {
      await remoteDatasource.updateChat(chat.id!, chat);
      return Result.success(() {});
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<List<Chat>>> getChatsForCommunityPrintRequest(String id) async {
    try {
      return Result.success(await remoteDatasource.getChatsForCommunityPrintRequest(id));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
}
