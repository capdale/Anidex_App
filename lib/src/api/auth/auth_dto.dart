import 'package:json_annotation/json_annotation.dart';

part 'auth_dto.g.dart';

@JsonSerializable()
class RefreshTokenRes {
  @JsonKey(name: "access_token")
  final String accessToken;
  @JsonKey(name: "refresh_token")
  final String refreshToken;
  RefreshTokenRes(this.accessToken, this.refreshToken);
  factory RefreshTokenRes.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshTokenResToJson(this);
}
