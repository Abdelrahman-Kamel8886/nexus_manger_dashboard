import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String name;
  final String url;


  const LoginEntity({
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [name, url];
}

