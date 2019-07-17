import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class APIResponse {
  APIResponse({this.error = false, this.data});

  APIResponse.error({this.data}) : error = true;

  final bool error;

  final Map data;

  factory APIResponse.fromJson(Map<String, dynamic> json) =>
      _$APIResponseFromJson(json);

  Map<String, dynamic> toJson() => _$APIResponseToJson(this);
}
