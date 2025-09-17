import 'package:json_annotation/json_annotation.dart';

part 'media.g.dart';

/// Not in the domain but needed to reconstruct the fileUri form the media endpoint
@JsonSerializable()
class Media {
  final String fileUri;

  Media(this.fileUri);

  factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

  Map<String, dynamic> toJson() => _$MediaToJson(this);
}
