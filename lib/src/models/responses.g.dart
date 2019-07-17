// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIResponse _$APIResponseFromJson(Map<String, dynamic> json) {
  return APIResponse(
      error: json['error'] as bool, data: json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$APIResponseToJson(APIResponse instance) =>
    <String, dynamic>{'error': instance.error, 'data': instance.data};
