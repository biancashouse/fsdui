// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthStateModelImpl _$$AuthStateModelImplFromJson(Map<String, dynamic> json) =>
    _$AuthStateModelImpl(
      status:
          $enumDecodeNullable(_$AuthStatusEnumMap, json['status']) ??
          AuthStatus.unknown,
      email: json['email'] as String?,
      token: json['token'] as String? ?? '',
    );

Map<String, dynamic> _$$AuthStateModelImplToJson(
  _$AuthStateModelImpl instance,
) => <String, dynamic>{
  'status': _$AuthStatusEnumMap[instance.status]!,
  'email': instance.email,
  'token': instance.token,
};

const _$AuthStatusEnumMap = {
  AuthStatus.unknown: 'unknown',
  AuthStatus.authenticated: 'authenticated',
  AuthStatus.unauthenticated: 'unauthenticated',
};
