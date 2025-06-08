import 'package:reconstructitapp/domain/entity_models/community_print_request.dart';
import 'package:reconstructitapp/domain/entity_models/item.dart';
import 'package:reconstructitapp/domain/entity_models/item_image.dart';

import '../../domain/entity_models/chat.dart';

class YourRequestsBodyViewModel {
  final List<Chat>? chats;
  final CommunityPrintRequest? communityPrintRequest;
  final Item item;
  final List<ItemImage>? images;

  YourRequestsBodyViewModel(
    this.chats,
    this.communityPrintRequest,
    this.item,
    this.images,
  );
}
