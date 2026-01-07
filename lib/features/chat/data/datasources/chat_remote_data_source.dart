import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Stream<List<ChatModel>> getChats();
  Stream<List<MessageModel>> getMessages(String chatId);
  Future<void> sendMessage(String chatId, String text);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRemoteDataSourceImpl({required this.firestore, required this.auth});

  @override
  Stream<List<ChatModel>> getChats() {
    final user = auth.currentUser;
    if (user == null) return Stream.value([]);

    // Logic: find chats where current user is a participant.
    // For simplicity in this refactoring, let's assume a 'participants' array in 'chats'
    return firestore
        .collection('chats')
        .where('participants', arrayContains: user.uid)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => ChatModel.fromFirestore(doc)).toList(),
        );
  }

  @override
  Stream<List<MessageModel>> getMessages(String chatId) {
    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => MessageModel.fromFirestore(doc))
              .toList(),
        );
  }

  @override
  Future<void> sendMessage(String chatId, String text) async {
    final user = auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    await firestore.collection('chats').doc(chatId).collection('messages').add({
      'senderId': user.uid,
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Update last message in chat document
    await firestore.collection('chats').doc(chatId).update({
      'lastMessage': text,
      'lastMessageTime': FieldValue.serverTimestamp(),
    });
  }
}


