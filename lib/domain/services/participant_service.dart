import 'dart:async';

import 'package:clean_ressource_tracker/clean_ressource_tracker.dart';

import '../../utils/result.dart';
import '../entity_models/participant.dart';

part 'participant_service.cpu_active_time.decorator.dart';
part 'participant_service.builder.dart';

@WithBuilder()
@MeasureCpuActiveTime()
abstract class ParticipantService {
  Future<Result<List<Participant>>> getParticipantsForUser(String userId);

  Future<Result<List<Participant>>> getParticipantsForContract(String contractId);

  Future<Result<Participant>> getParticipant(String id);

  Future<Result<Participant>> createParticipant(Participant participant);
}
