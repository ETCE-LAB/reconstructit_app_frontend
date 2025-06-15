import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:reconstructitapp/domain/services/media_service.dart';
import 'package:reconstructitapp/domain/services/user_service.dart';
import 'package:reconstructitapp/infrastructure/repositories/media_repository.dart';
import 'package:reconstructitapp/infrastructure/repositories/message_repository.dart';
import 'package:reconstructitapp/infrastructure/repositories/user_repository.dart';
import 'package:reconstructitapp/infrastructure/sources/remote_datasource.dart';
import 'package:reconstructitapp/presentation/start/bloc/initial_bloc.dart';
import 'package:reconstructitapp/presentation/your_requests/bloc/your_items_bloc.dart';

import '../domain/services/address_service.dart';
import '../domain/services/chat_service.dart';
import '../domain/services/community_print_request_service.dart';
import '../domain/services/construction_file_service.dart';
import '../domain/services/item_image_service.dart';
import '../domain/services/item_service.dart';
import '../domain/services/message_service.dart';
import '../domain/services/participant_service.dart';
import '../infrastructure/repositories/address_repository.dart';
import '../infrastructure/repositories/chat_repository.dart';
import '../infrastructure/repositories/community_print_request_repository.dart';
import '../infrastructure/repositories/construction_file_repository.dart';
import '../infrastructure/repositories/item_image_repository.dart';
import '../infrastructure/repositories/item_repository.dart';
import '../infrastructure/repositories/participant_repository.dart';
import '../infrastructure/sources/account_local_datasource.dart';
import '../presentation/account/bloc/user_bloc.dart';
import '../presentation/authentication/bloc/authentication_bloc.dart';
import '../presentation/create_or_edit_request/bloc/create_or_edit_request_bloc.dart';
import '../presentation/home/bloc/home_bloc.dart';
import 'clients/app_http_client.dart';

final ic = GetIt.instance;

Future<void> initDependencies() async {
  // Blocs
  ic.registerFactory<InitialBloc>(() => InitialBloc());

  ic.registerFactory<AuthenticationBloc>(() => AuthenticationBloc());
  ic.registerFactory<HomeBloc>(() => HomeBloc());
  ic.registerFactory<UserBloc>(() => UserBloc(ic()));
  ic.registerFactory<YourItemsBloc>(
    () => YourItemsBloc(ic(), ic(), ic(), ic(), ic()),
  );
  ic.registerFactory<CreateOrEditRequestBloc>(
    () => CreateOrEditRequestBloc(ic(), ic(), ic(), ic(), ic()),
  );
  // Services
  ic.registerLazySingleton<UserService>(() => UserRepository(ic(), ic()));
  ic.registerLazySingleton<AddressService>(() => AddressRepository(ic()));
  ic.registerLazySingleton<ChatService>(() => ChatRepository(ic()));
  ic.registerLazySingleton<CommunityPrintRequestService>(
    () => CommunityPrintRequestRepository(ic()),
  );
  ic.registerLazySingleton<ConstructionFileService>(
    () => ConstructionFileRepository(ic()),
  );
  ic.registerLazySingleton<ItemService>(() => ItemRepository(ic()));
  ic.registerLazySingleton<ItemImageService>(() => ItemImageRepository(ic()));
  ic.registerLazySingleton<MessageService>(() => MessageRepository(ic()));
  ic.registerLazySingleton<ParticipantService>(
    () => ParticipantRepository(ic()),
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
