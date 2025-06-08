import 'dart:async';

import '../../utils/result.dart';
import '../entity_models/community_print_request.dart';

abstract class CommunityPrintRequestService {
  Future<Result<List<CommunityPrintRequest>>> getAllCommunityPrintRequests();

  Future<Result<CommunityPrintRequest>> getCommunityPrintRequest(String id);

  Future<Result<CommunityPrintRequest>> createCommunityPrintRequest(CommunityPrintRequest request);

  Future<Result<void>> updateCommunityPrintRequest(CommunityPrintRequest request);

  Future<Result<void>> deleteCommunityPrintRequest(String id);
}
