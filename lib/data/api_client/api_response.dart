import 'package:json_annotation/json_annotation.dart';
part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse<T> {
  dynamic data;
  dynamic message;
  dynamic status;
  dynamic time;
  dynamic count;
  dynamic next;
  dynamic previous;

  ApiResponse(
    this.data,
    this.message,
    this.status,
    this.time,
    this.count,
    this.next,
    this.previous,
  );

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
