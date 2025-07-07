
class RequestDetailEvent {}

class RequestDetailRefresh extends RequestDetailEvent {
  final String communityPrintRequestId;
  RequestDetailRefresh(this.communityPrintRequestId);
}
