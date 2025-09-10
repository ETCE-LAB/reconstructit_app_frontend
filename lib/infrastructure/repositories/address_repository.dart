import '../../domain/entity_models/address.dart';
import '../../domain/services/address_service.dart';
import '../../utils/result.dart';
import '../sources/remote_datasource.dart';

class AddressRepository implements AddressService {
  final IRemoteDatasource remoteDatasource;

  AddressRepository(this.remoteDatasource);

  @override
  Future<Result<Address>> getAddress(String id) async {
    try {
      return Result.success(await remoteDatasource.getAddress(id));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<Address>> createAddress(Address address) async {
    try {
      return Result.success(await remoteDatasource.createAddress(address));
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<void>> editAddress(Address address) async {
    try {
      return Result.success(
        await remoteDatasource.editAddress(address.id!, address),
      );
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<void>> deleteAddress(String id) async{
    try {
      return Result.success(
        await remoteDatasource.deleteAddress(id),
      );
    } catch (e) {
      return Result.fail(e as Exception);
    }
  }

  @override
  Future<Result<Address>> getAddressByUserId(String userId) async{
    try {
      return Result.success(await remoteDatasource.getAddressForUser(userId));
    } catch (e) {
    return Result.fail(e as Exception);
    }
  }
}
