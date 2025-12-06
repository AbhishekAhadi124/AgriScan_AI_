// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<T> _$ApiResponseFromJson<T>(Map<String, dynamic> json) =>
    ApiResponse<T>(
      json['data'],
      json['message'],
      json['status'],
      json['time'],
      json['count'],
      json['next'],
      json['previous'],
    );

Map<String, dynamic> _$ApiResponseToJson<T>(ApiResponse<T> instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'status': instance.status,
      'time': instance.time,
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
    };
