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

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      name: json['name'] as String? ?? '',
      format: json['format'] as String? ?? '',
      type: json['type'] as String? ?? '',
      url: json['url'] as String? ?? '',
      size: json['size'] as int? ?? 0,
      attributes: json['attributes'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'format': format,
      'type': type,
      'url': url,
      'size': size,
      'attributes': attributes,
    };
  }
}

