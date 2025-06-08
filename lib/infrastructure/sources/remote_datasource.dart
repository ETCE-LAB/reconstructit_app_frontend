import 'dart:io';

import 'package:dio/dio.dart';
import 'package:reconstructitapp/domain/entity_models/community_print_request.dart';
import 'package:reconstructitapp/domain/entity_models/media.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/entity_models/address.dart';
import '../../domain/entity_models/chat.dart';
import '../../domain/entity_models/construction_file.dart';
import '../../domain/entity_models/item.dart';
import '../../domain/entity_models/item_image.dart';
import '../../domain/entity_models/message.dart';
import '../../domain/entity_models/participant.dart';
import '../../domain/entity_models/user.dart';

part 'remote_datasource.g.dart';

@RestApi(
  baseUrl:
      'https://reconstructitbackend-b8dcdscua2bcfxdf.northeurope-01.azurewebsites.net/',
)
abstract class IRemoteDatasource {
  factory IRemoteDatasource(Dio dio, {String baseUrl}) = _IRemoteDatasource;

  // USERS
  @GET('/api/Users/{id}')
  Future<User> getUser(@Path() String id);

  @GET('/api/application-users/{id}/User')
  Future<User> getUserWithUserAccountId(@Path() String id);

  @POST('/api/Users')
  Future<User> createUserProfile(@Body() User user);

  @PUT('/api/Users/{id}')
  Future<void> editUserProfile(@Path() String id, @Body() User user);

  // ADDRESSES
  @GET('/api/Addresses/{id}')
  Future<Address> getAddress(@Path() String id);

  @POST('/api/Addresses')
  Future<Address> createAddress(@Body() Address address);

  // CHATS
  @GET('/api/Chats/{id}')
  Future<Chat> getChat(@Path() String id);

  @POST('/api/Chats')
  Future<Chat> createChat(@Body() Chat chat);

  @PUT('/api/Chats/{id}')
  Future<void> updateChat(@Path() String id, @Body() Chat chat);

  @GET('/api/CommunityPrintRequests/{id}/Chats')
  Future<List<Chat>> getChatsForCommunityPrintRequest(@Path() String id);

  // COMMUNITY PRINT REQUESTS
  @GET('/api/CommunityPrintRequests')
  Future<List<CommunityPrintRequest>> getCommunityPrintRequests();

  @POST('/api/CommunityPrintRequests')
  Future<CommunityPrintRequest> createCommunityPrintRequest(
    @Body() CommunityPrintRequest communityPrintRequest,
  );

  @GET('/api/CommunityPrintRequests/{id}')
  Future<CommunityPrintRequest> getCommunityPrintRequest(@Path() String id);

  @PUT('/api/CommunityPrintRequests/{id}')
  Future<void> updateCommunityPrintRequest(
    @Path() String id,
    @Body() CommunityPrintRequest communityPrintRequest,
  );

  @DELETE('/api/CommunityPrintRequests/{id}')
  Future<void> deleteCommunityPrintRequest(@Path() String id);

  // CONSTRUCTION FILES
  @GET('/api/ConstructionFiles/{id}')
  Future<ConstructionFile> getConstructionFile(@Path() String id);

  @POST('/api/ConstructionFiles')
  Future<ConstructionFile> createConstructionFile(
    @Body() ConstructionFile constructionFile,
  );

  @PUT('/api/ConstructionFiles/{id}')
  Future<void> updateConstructionFile(
    @Path() String id,
    @Body() ConstructionFile constructionFile,
  );

  // ITEMS
  @GET('/api/Items/{id}')
  Future<Item> getItem(@Path() String id);

  @POST('/api/Items')
  Future<Item> createItem(@Body() Item item);

  @PUT('/api/Items/{id}')
  Future<void> updateItem(@Path() String id, @Body() Item item);

  @GET('/api/Users/{userId}/Items')
  Future<List<Item>> getItemsByUser(@Path() String userId);

  // ITEM IMAGES
  @GET('/api/Items/{id}/ItemImages')
  Future<List<ItemImage>> getItemImagesForItem(@Path() String id);

  @POST('/api/ItemImages')
  Future<ItemImage> createItemImage(@Body() ItemImage itemImage);

  @DELETE('/api/ItemImages/{id}')
  Future<void> deleteItemImage(@Path() String id);

  // MESSAGES
  @GET('/api/Chats/{chatId}/Messages')
  Future<List<Message>> getMessagesByChatId(@Path() String chatId);

  @GET('/api/Messages/{id}')
  Future<Message> getMessage(@Path() String id);

  @POST('/api/Messages')
  Future<Message> createMessage(@Body() Message message);

  // PARTICIPANTS
  @GET('/api/Users/{userId}/Participants')
  Future<List<Participant>> getParticipantsByUser(@Path() String userId);

  @GET('/api/Chats/{chatId}/Participants')
  Future<List<Participant>> getParticipantsByChat(@Path() String chatId);

  @GET('/api/Participants/{id}')
  Future<Participant> getParticipant(@Path() String id);

  @POST('/api/Participants')
  Future<Participant> createParticipant(@Body() Participant participant);

  // MEDIA
  @POST('/api/Media')
  @MultiPart()
  Future<Media> postImage(@Part(contentType: 'image/jpg') File media);
}
