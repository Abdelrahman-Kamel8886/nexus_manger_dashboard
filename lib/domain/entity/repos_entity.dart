import 'package:equatable/equatable.dart';

class RepoEntity extends Equatable {
  final String name;
  final String url;


  const RepoEntity({
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [name, url];
}

