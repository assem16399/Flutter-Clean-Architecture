import 'package:equatable/equatable.dart';

class Post with EquatableMixin {
  final int id;
  final String title;
  final String body;

  const Post({required this.id, required this.title, required this.body});

  @override
  List<Object?> get props => [id, title, body];

  @override
  bool? get stringify => true;
}
