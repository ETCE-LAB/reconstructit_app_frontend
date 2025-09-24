
class OthersRequestDetailEvent {}

class OthersRequestDetailRefresh extends OthersRequestDetailEvent {
  final String communityPrintRequestId;
  OthersRequestDetailRefresh(this.communityPrintRequestId);
}
