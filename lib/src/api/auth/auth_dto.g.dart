// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenRes _$RefreshTokenResFromJson(Map<String, dynamic> json) =>
    RefreshTokenRes(
      json['access_token'] as String,
      json['refresh_token'] as String,
    );

Map<String, dynamic> _$RefreshTokenResToJson(RefreshTokenRes instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
