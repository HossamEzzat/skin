import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String id;
  final String otherUserId;
  final String otherUserName;
  final String otherUserImage;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  const ChatEntity({
    required this.id,
    required this.otherUserId,
    required this.otherUserName,
    required this.otherUserImage,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
  });

  @override
  List<Object?> get props => [
    id,
    otherUserId,
    otherUserName,
    otherUserImage,
    lastMessage,
    lastMessageTime,
    unreadCount,
  ];
}


