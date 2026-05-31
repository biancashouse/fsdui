// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthStateImpl _$$AuthStateImplFromJson(Map<String, dynamic> json) =>
    _$AuthStateImpl(
      ea: json['ea'] as String?,
      token: json['token'] as String?,
      isLoading: json['isLoading'] as bool? ?? false,
      verified: json['verified'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$AuthStateImplToJson(_$AuthStateImpl instance) =>
    <String, dynamic>{
      'ea': instance.ea,
      'token': instance.token,
      'isLoading': instance.isLoading,
      'verified': instance.verified,
      'errorMessage': instance.errorMessage,
    };
