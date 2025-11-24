// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// MeasureCpuActiveTimeGenerator
// **************************************************************************

part of 'print_contract_service.dart';

class PrintContractServiceCpuActiveTimeDecorator extends PrintContractService {
  final PrintContractService _inner;
  PrintContractServiceCpuActiveTimeDecorator(this._inner);
  @override
  Future<Result<PrintContract>> createPrintContract(
    PrintContract contract,
  ) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.createPrintContract(contract);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for createPrintContract: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<void>> updatePrintContract(PrintContract contract) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.updatePrintContract(contract);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for updatePrintContract: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<List<PrintContract>>> getContractsForRequest(
    String requestId,
  ) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getContractsForRequest(requestId);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getContractsForRequest: ${end - start}ms");
    return result;
  }

  @override
  Future<Result<PrintContract>> getContract(String id) async {
    final start = await CPUActiveTImePlatformChannel.getCPUTime();
    final result = await _inner.getContract(id);
    final end = await CPUActiveTImePlatformChannel.getCPUTime();
    print("CPU time for getContract: ${end - start}ms");
    return result;
  }
}
