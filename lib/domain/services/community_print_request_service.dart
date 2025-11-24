import 'dart:async';
import 'package:clean_ressource_tracker/clean_ressource_tracker.dart';
import '../../utils/result.dart';
import '../entity_models/community_print_request.dart';

part 'community_print_request_service.cpu_active_time.decorator.dart';

part 'community_print_request_service.builder.dart';

@MeasureCpuActiveTime()
@WithBuilder()
abstract class CommunityPrintRequestService {
  Future<Result<List<CommunityPrintRequest>>> getAllCommunityPrintRequests();

  Future<Result<CommunityPrintRequest>> getCommunityPrintRequest(String id);

  Future<Result<CommunityPrintRequest>> createCommunityPrintRequest(
      CommunityPrintRequest request,);

  Future<Result<void>> updateCommunityPrintRequest(
      CommunityPrintRequest request,);

  Future<Result<void>> deleteCommunityPrintRequest(String id);
}
