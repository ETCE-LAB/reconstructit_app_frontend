import 'package:reconstructitapp/presentation/community/community_body_view_model.dart';

abstract class CommunityState {}

class CommunityInitial extends CommunityState {}

class CommunityLoading extends CommunityState {}

class CommunityLoaded extends CommunityState {
  final List<CommunityBodyViewModel> communityBodyViewModels;

  CommunityLoaded(this.communityBodyViewModels);
}

class CommunityFailed extends CommunityState {
  final Exception exception;

  CommunityFailed(this.exception);
}
