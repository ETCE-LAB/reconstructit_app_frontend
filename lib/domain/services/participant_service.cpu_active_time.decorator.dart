// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// MeasureCpuActiveTimeGenerator
// **************************************************************************

part of 'participant_service.dart';

class ParticipantServiceCpuActiveTimeDecorator extends ParticipantService {
  final ParticipantService _inner;
  ParticipantServiceCpuActiveTimeDecorator(this._inner);
  @override
  Future<Result<List<Participant>>> getParticipantsForUser(
    String userId,
  ) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getParticipantsForUser(userId);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getParticipantsForUser: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<List<Participant>>> getParticipantsForContract(
    String contractId,
  ) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getParticipantsForContract(contractId);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getParticipantsForContract: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<Participant>> getParticipant(String id) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getParticipant(id);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getParticipant: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<Participant>> createParticipant(Participant participant) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.createParticipant(participant);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for createParticipant: ${end - start}ms");
    return result;
  }
}
