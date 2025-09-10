import 'dart:async';

import '../../utils/result.dart';
import '../entity_models/participant.dart';

abstract class ParticipantService {
  Future<Result<List<Participant>>> getParticipantsForUser(String userId);

  Future<Result<List<Participant>>> getParticipantsForContract(String contractId);

  Future<Result<Participant>> getParticipant(String id);

  Future<Result<Participant>> createParticipant(Participant participant);
}
