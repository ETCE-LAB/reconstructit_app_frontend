import '../../domain/entity_models/participant.dart';
import '../../domain/services/participant_service.dart';
import '../../utils/result.dart';
import '../sources/remote_datasource.dart';

class ParticipantRepository implements ParticipantService {
  final IRemoteDatasource remoteDatasource;

  ParticipantRepository(this.remoteDatasource);

  @override
  Future<Result<List<Participant>>> getParticipantsForUser(String userId) async {
    try {
      return Result.success(
          await remoteDatasource.getParticipantsByUser(userId));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<List<Participant>>> getParticipantsForChat(String chatId) async {
    try {
      return Result.success(
          await remoteDatasource.getParticipantsByChat(chatId));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<Participant>> getParticipant(String id) async {
    try {
      return Result.success(await remoteDatasource.getParticipant(id));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<Participant>> createParticipant(Participant participant) async {
    try {
      return Result.success(
          await remoteDatasource.createParticipant(participant));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
}