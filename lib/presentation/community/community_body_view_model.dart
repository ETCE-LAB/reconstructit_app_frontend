import 'package:reconstructitapp/domain/entity_models/community_print_request.dart';
import 'package:reconstructitapp/domain/entity_models/construction_file.dart';
import 'package:reconstructitapp/domain/entity_models/item.dart';
import 'package:reconstructitapp/domain/entity_models/item_image.dart';

import '../../domain/entity_models/user.dart';

class CommunityBodyViewModel {
  final User? user;
  final CommunityPrintRequest communityPrintRequest;
  final Item item;
  final List<ItemImage>? images;
  final ConstructionFile? constructionFile;

  CommunityBodyViewModel(
    this.user,
    this.communityPrintRequest,
    this.item,
    this.images,
    this.constructionFile,
  );
}
