import 'package:equatable/equatable.dart';
import '../../../auth/domain/entities/user_entity.dart';

class ChatEntity extends Equatable {
  final String id;
  final UserEntity user1;
  final UserEntity user2;

  const ChatEntity({required this.id, required this.user1, required this.user2});

  @override
  List<Object?> get props => [id, user1, user2];
}