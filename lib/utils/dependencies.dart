import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:reconstructitapp/domain/services/media_service.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';
import 'package:reconstructitapp/infrastructure/repositories/media_repository.dart';
import 'package:reconstructitapp/infrastructure/repositories/user_repository.dart';
import 'package:reconstructitapp/infrastructure/sources/remote_datasource.dart';
import 'package:reconstructitapp/presentation/all_print_contracts/bloc/print_contract_bloc.dart';
import 'package:reconstructitapp/presentation/choose_payment_method/bloc/payment_methods_bloc.dart';
import 'package:reconstructitapp/presentation/community/bloc/community_bloc.dart';
import 'package:reconstructitapp/presentation/create_or_edit_user/bloc/create_or_edit_user_bloc.dart';
import 'package:reconstructitapp/presentation/logout/bloc/logout_bloc.dart';
import 'package:reconstructitapp/presentation/print_contract/bloc/data/print_contract_bloc.dart';
import 'package:reconstructitapp/presentation/print_contract/bloc/interaction/edit_print_contract_bloc.dart';
import 'package:reconstructitapp/presentation/request_detail/bloc/request_detail_bloc.dart';
import 'package:reconstructitapp/presentation/request_detail/create_chat_bloc/create_print_contract_bloc.dart';
import 'package:reconstructitapp/presentation/start/bloc/initial_bloc.dart';
import 'package:reconstructitapp/presentation/your_requests/bloc/your_items_bloc.dart';

import '../domain/services/address_service.dart';
import '../domain/services/community_print_request_service.dart';
import '../domain/services/construction_file_service.dart';
import '../domain/services/item_image_service.dart';
import '../domain/services/item_service.dart';
import '../domain/services/participant_service.dart';
import '../domain/services/payment_attribute_service.dart';
import '../domain/services/payment_method_service.dart';
import '../domain/services/payment_service.dart';
import '../domain/services/payment_value_service.dart';
import '../domain/services/print_contract_service.dart';
import '../infrastructure/repositories/address_repository.dart';
import '../infrastructure/repositories/community_print_request_repository.dart';
import '../infrastructure/repositories/construction_file_repository.dart';
import '../infrastructure/repositories/item_image_repository.dart';
import '../infrastructure/repositories/item_repository.dart';
import '../infrastructure/repositories/participant_repository.dart';
import '../infrastructure/repositories/payment_attribute_repository.dart';
import '../infrastructure/repositories/payment_method_repository.dart';
import '../infrastructure/repositories/payment_repository.dart';
import '../infrastructure/repositories/payment_value_repository.dart';
import '../infrastructure/repositories/print_contract_repository.dart';
import '../infrastructure/sources/account_local_datasource.dart';
import '../presentation/authentication/bloc/authentication_bloc.dart';
import '../presentation/create_or_edit_request/bloc/create_or_edit_request_bloc.dart';
import '../presentation/home/bloc/home_bloc.dart';
import '../presentation/user/bloc/user_bloc.dart';
import 'clients/app_http_client.dart';

final ic = GetIt.instance;

Future<void> initDependencies() async {
  // Blocs
  ic.registerFactory<InitialBloc>(() => InitialBloc());

  ic.registerFactory<AuthenticationBloc>(() => AuthenticationBloc());
  ic.registerFactory<HomeBloc>(() => HomeBloc(ic()));
  ic.registerFactory<LogoutBloc>(() => LogoutBloc());
  ic.registerFactory<UserBloc>(() => UserBloc(ic(), ic()));

  ic.registerFactory<CreatePrintContractBloc>(
    () => CreatePrintContractBloc(ic(), ic(), ic(), ic(), ic()),
  );
  ic.registerFactory<RequestDetailBloc>(
    () => RequestDetailBloc(ic(), ic(), ic(), ic()),
  );
  ic.registerFactory<CommunityBloc>(
    () => CommunityBloc(ic(), ic(), ic(), ic()),
  );
  ic.registerFactory<PaymentMethodsBloc>(() => PaymentMethodsBloc(ic(), ic()));

  ic.registerFactory<CreateOrEditUserBloc>(
    () => CreateOrEditUserBloc(ic(), ic(), ic()),
  );
  ic.registerFactory<YourItemsBloc>(
    () => YourItemsBloc(ic(), ic(), ic(), ic(), ic()),
  );
  ic.registerFactory<PrintContractBloc>(
    () =>
        PrintContractBloc(ic(), ic(), ic(), ic(), ic(), ic(), ic(), ic(), ic()),
  );

  ic.registerFactory<EditPrintContractBloc>(
        () =>
            EditPrintContractBloc(ic(), ic()),
  );
  ic.registerFactory<AllPrintContractsBloc>(
    () => AllPrintContractsBloc(ic(), ic(), ic(), ic(), ic(), ic()),
  );
  ic.registerFactory<CreateOrEditRequestBloc>(
    () => CreateOrEditRequestBloc(ic(), ic(), ic(), ic(), ic(), ic()),
  );
  // Services
  ic.registerLazySingleton<UserService>(() => UserRepository(ic(), ic()));
  ic.registerLazySingleton<AddressService>(() => AddressRepository(ic()));
  ic.registerLazySingleton<CommunityPrintRequestService>(
    () => CommunityPrintRequestRepository(ic()),
  );
  ic.registerLazySingleton<ConstructionFileService>(
    () => ConstructionFileRepository(ic()),
  );
  ic.registerLazySingleton<ItemService>(() => ItemRepository(ic()));
  ic.registerLazySingleton<ItemImageService>(() => ItemImageRepository(ic()));
  ic.registerLazySingleton<ParticipantService>(
    () => ParticipantRepository(ic()),
  );
  ic.registerLazySingleton<PaymentMethodService>(
    () => PaymentMethodRepository(ic()),
  );
  ic.registerLazySingleton<PaymentAttributeService>(
    () => PaymentAttributeRepository(ic()),
  );
  ic.registerLazySingleton<PaymentService>(() => PaymentRepository(ic()));
  ic.registerLazySingleton<PaymentValueService>(
    () => PaymentValueRepository(ic()),
  );
  ic.registerLazySingleton<PrintContractService>(
    () => PrintContractRepository(ic()),
  );

  ic.registerLazySingleton<MediaService>(() => MediaRepository(ic()));
  // Sources
  ic.registerLazySingleton<IRemoteDatasource>(() => IRemoteDatasource(ic()));
  ic.registerLazySingleton<IAccountLocalDatasource>(
    () => AccountLocalDatasource(),
  );
  // Helper
  ic.registerLazySingleton<Dio>(() => dio);
}
