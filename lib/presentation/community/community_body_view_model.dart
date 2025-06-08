import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reconstructitapp/domain/entity_models/community_print_request.dart';
import 'package:reconstructitapp/domain/entity_models/enums/chat_status.dart';
import 'package:reconstructitapp/domain/entity_models/item.dart';
import 'package:reconstructitapp/domain/entity_models/participant.dart';

import '../../domain/entity_models/chat.dart';
import '../../domain/entity_models/message.dart';
import '../../domain/entity_models/user.dart';

class CommunityBodyViewModel {

  final User user;
  final CommunityPrintRequest communityPrintRequest;
  final Item item;

  CommunityBodyViewModel( this.user, this.communityPrintRequest, this.item);

}