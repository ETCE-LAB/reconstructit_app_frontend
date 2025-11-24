import 'package:clean_ressource_tracker/clean_ressource_tracker.dart';

import '../entity_models/print_contract.dart';
import '../../utils/result.dart';


part 'print_contract_service.cpu_active_time.decorator.dart';
part 'print_contract_service.builder.dart';

@WithBuilder()
@MeasureCpuActiveTime()
abstract class PrintContractService {
  Future<Result<PrintContract>> createPrintContract(PrintContract contract);

  Future<Result<void>> updatePrintContract(PrintContract contract);

  Future<Result<List<PrintContract>>> getContractsForRequest(String requestId);

  Future<Result<PrintContract>> getContract(String id);
}
