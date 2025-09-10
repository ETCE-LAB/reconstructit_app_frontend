import '../../domain/entity_models/print_contract.dart';
import '../../domain/services/print_contract_service.dart';
import '../../utils/result.dart';
import '../sources/remote_datasource.dart';

class PrintContractRepository implements PrintContractService {
  final IRemoteDatasource remoteDatasource;

  PrintContractRepository(this.remoteDatasource);

  @override
  Future<Result<PrintContract>> createPrintContract(
    PrintContract contract,
  ) async {
    try {
      return Result.success(
        await remoteDatasource.createPrintContract(contract),
      );
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<void>> updatePrintContract(PrintContract contract) async {
    try {
      await remoteDatasource.updatePrintContract(contract.id!, contract);
      return Result.success(() {});
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<List<PrintContract>>> getContractsForRequest(
    String requestId,
  ) async {
    try {
      return Result.success(
        await remoteDatasource.getContractsForRequest(requestId),
      );
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<PrintContract>> getContract(String id) async {
    try {
      return Result.success(await remoteDatasource.getContract(id));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }
}
