import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  final String name;
  final String format;
  final String type;
  final String url;
  final int size;
  final Map<String, dynamic> attributes;

  LoginModel({
    required this.name,
    required this.format,
    required this.type,
    required this.url,
    required this.size,
    required this.attributes,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

