import 'dart:async';

import '../../utils/result.dart';
import '../entity_models/community_print_request.dart';

abstract class CommunityPrintRequestService {
  /// Get all community print requests - used for browsing
  Future<Result<List<CommunityPrintRequest>>> getAllCommunityPrintRequests();

  /// Get a community print request by id - used to get a request to an own item
  Future<Result<CommunityPrintRequest>> getCommunityPrintRequest(String id);

  Future<Result<CommunityPrintRequest>> createCommunityPrintRequest(CommunityPrintRequest request);

  Future<Result<void>> updateCommunityPrintRequest(CommunityPrintRequest request);

  Future<Result<void>> deleteCommunityPrintRequest(String id);
}
