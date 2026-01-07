import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skin/features/article/domain/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required super.id,
    required super.title,
    required super.description,
    required super.content,
    required super.category,
    required super.authorName,
    required super.image,
    required super.date,
    required super.duration,
    required super.ingredients,
    required super.likes,
  });

  factory ArticleModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ArticleModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      content: data['content'] ?? '',
      category: data['category'] ?? '',
      authorName: data['authorName'] ?? '',
      image: data['image'] ?? '',
      date: data['date'] ?? '',
      duration: data['duration'] ?? '',
      ingredients: List<String>.from(data['ingredients'] ?? []),
      likes: data['likes'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'content': content,
      'category': category,
      'authorName': authorName,
      'image': image,
      'date': date,
      'duration': duration,
      'ingredients': ingredients,
      'likes': likes,
    };
  }
}


