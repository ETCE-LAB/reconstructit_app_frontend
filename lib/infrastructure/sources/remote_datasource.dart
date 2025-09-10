import 'dart:io';

import 'package:dio/dio.dart';
import 'package:reconstructitapp/domain/entity_models/community_print_request.dart';
import 'package:reconstructitapp/domain/entity_models/media.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/entity_models/address.dart';
import '../../domain/entity_models/construction_file.dart';
import '../../domain/entity_models/item.dart';
import '../../domain/entity_models/item_image.dart';
import '../../domain/entity_models/participant.dart';
import '../../domain/entity_models/payment.dart';
import '../../domain/entity_models/payment_attribute.dart';
import '../../domain/entity_models/payment_method.dart';
import '../../domain/entity_models/payment_value.dart';
import '../../domain/entity_models/print_contract.dart';
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

  @GET('/api/Users/{id}/Address')
  Future<Address> getAddressForUser(@Path() String id);

  @POST('/api/Addresses')
  Future<Address> createAddress(@Body() Address address);

  @PUT('/api/Addresses/{id}')
  Future<void> editAddress(@Path() String id, @Body() Address address);

  @DELETE('/api/Addresses/{id}')
  Future<void> deleteAddress(@Path() String id);

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

  // PARTICIPANTS
  @GET('/api/Users/{userId}/Participants')
  Future<List<Participant>> getParticipantsByUser(@Path() String userId);

  @GET('/api/PrintContract/{contractId}/Participants')
  Future<List<Participant>> getParticipantsByContract(@Path() String contractId);

  @GET('/api/Participants/{id}')
  Future<Participant> getParticipant(@Path() String id);

  @POST('/api/Participants')
  Future<Participant> createParticipant(@Body() Participant participant);

  // PAYMENT ATTRIBUTES
  @GET('/api/PaymentMethodDefinition/{id}/PaymentAttributes')
  Future<List<PaymentAttribute>> getPaymentAttributesForDefinition(@Path() String id);

  @GET('/api/PaymentAttributes/{id}')
  Future<PaymentAttribute> getPaymentAttribute(@Path() String id);

  // PAYMENT METHODS
  @GET('/api/PaymentMethods')
  Future<List<PaymentMethod>> getAllPaymentMethods();

  @GET('/api/PaymentMethods/{id}')
  Future<PaymentMethod> getPaymentMethod(@Path() String id);

  // PAYMENTS
  @POST('/api/Payments')
  Future<Payment> createPayment(@Body() Payment payment);

  @PUT('/api/Payments/{id}')
  Future<void> updatePayment(@Path() String id, @Body() Payment payment);

  @GET('/api/Payments/{id}')
  Future<Payment> getPayment(@Path() String id);

  // PAYMENT VALUES
  @POST('/api/PaymentValues')
  Future<PaymentValue> createPaymentValue(@Body() PaymentValue paymentValue);

  @GET('/api/Payment/{id}/PaymentValues')
  Future<List<PaymentValue>> getPaymentValuesForPayment(@Path() String id);

  // PRINT CONTRACTS
  @POST('/api/PrintContracts')
  Future<PrintContract> createPrintContract(@Body() PrintContract contract);

  @PUT('/api/PrintContracts/{id}')
  Future<void> updatePrintContract(@Path() String id, @Body() PrintContract contract);

  @GET('/api/CommunityPrintRequest/{id}/PrintContracts')
  Future<List<PrintContract>> getContractsForRequest(@Path() String id);

  @GET('/api/PrintContracts/{id}')
  Future<PrintContract> getContract(@Path() String id);

  // MEDIA
  @POST('/api/Media')
  @MultiPart()
  Future<Media> postImage(@Part(contentType: 'image/jpg') File media);


  @POST('/api/Media')
  @MultiPart()
  Future<Media> postStl(@Part(contentType: 'application/sla') File media);
}
