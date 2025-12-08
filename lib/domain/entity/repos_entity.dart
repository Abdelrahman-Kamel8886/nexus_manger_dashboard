import 'package:equatable/equatable.dart';

class Repos extends Equatable {
  final String name;
  final String format;
  final String type;
  final String url;
  final int size;
  final Map<String, dynamic> attributes;

  const Repos({
    required this.name,
    required this.format,
    required this.type,
    required this.url,
    required this.size,
    required this.attributes,
  });

  @override
  List<Object?> get props => [name, format, type, url, size, attributes];
}

