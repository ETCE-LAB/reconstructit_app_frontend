import '../../domain/entity_models/community_print_request.dart';
import '../../domain/services/community_print_request_service.dart';
import '../../utils/result.dart';
import '../sources/remote_datasource.dart';

class CommunityPrintRequestRepository implements CommunityPrintRequestService {
  final IRemoteDatasource remoteDatasource;
  CommunityPrintRequestRepository(this.remoteDatasource);

  @override
  Future<Result<List<CommunityPrintRequest>>> getAllCommunityPrintRequests() async {
    try {
      return Result.success(await remoteDatasource.getCommunityPrintRequests());
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<CommunityPrintRequest>> getCommunityPrintRequest(String id) async {
    try {
      return Result.success(await remoteDatasource.getCommunityPrintRequest(id));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<CommunityPrintRequest>> createCommunityPrintRequest(CommunityPrintRequest request) async {
    try {
      return Result.success(await remoteDatasource.createCommunityPrintRequest(request));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<void>> updateCommunityPrintRequest(CommunityPrintRequest request) async {
    try {
      await remoteDatasource.updateCommunityPrintRequest(request.id!, request);
      return Result.success(() {});
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<void>> deleteCommunityPrintRequest(String id) async {
    try {
      await remoteDatasource.deleteCommunityPrintRequest(id);
      return Result.success(() {});
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
}