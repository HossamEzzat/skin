import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String content;
  final String category;
  final String authorName;
  final String image;
  final String date;
  final String duration;
  final List<String> ingredients;
  final int likes;

  const ArticleEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.category,
    required this.authorName,
    required this.image,
    required this.date,
    required this.duration,
    required this.ingredients,
    required this.likes,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    content,
    category,
    authorName,
    image,
    date,
    duration,
    ingredients,
    likes,
  ];
}


