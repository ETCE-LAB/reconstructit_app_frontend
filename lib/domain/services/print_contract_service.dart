import '../entity_models/print_contract.dart';
import '../../utils/result.dart';

abstract class PrintContractService {
  Future<Result<PrintContract>> createPrintContract(PrintContract contract);

  Future<Result<void>> updatePrintContract(PrintContract contract);

  Future<Result<List<PrintContract>>> getContractsForRequest(String requestId);

  Future<Result<PrintContract>> getContract(String id);
}
