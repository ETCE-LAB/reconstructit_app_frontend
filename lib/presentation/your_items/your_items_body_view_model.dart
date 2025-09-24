import 'package:reconstructitapp/domain/entity_models/community_print_request.dart';
import 'package:reconstructitapp/domain/entity_models/construction_file.dart';
import 'package:reconstructitapp/domain/entity_models/item.dart';
import 'package:reconstructitapp/domain/entity_models/item_image.dart';

class YourItemsBodyViewModel {
  final CommunityPrintRequest? communityPrintRequest;
  final Item item;
  final List<ItemImage>? images;
  final ConstructionFile? constructionFile;

  YourItemsBodyViewModel(
    this.communityPrintRequest,
    this.item,
    this.images,
    this.constructionFile,
  );
}
