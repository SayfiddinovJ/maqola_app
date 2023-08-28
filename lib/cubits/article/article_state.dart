import 'package:columnist/data/models/articles/article_model.dart';
import 'package:columnist/data/status.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ArticleState extends Equatable {
  final String statusText;
  final ArticleModel articleModel;
  ArticleModel? articleDetail;
  final List<ArticleModel> articles;
  final FormStatus status;

  ArticleState({
    required this.articleModel,
    this.articleDetail,
    this.statusText = "",
    this.status = FormStatus.pure,
    required this.articles,
  });

  ArticleState copyWith({
    String? statusText,
    ArticleModel? articleModel,
    ArticleModel? articleDetail,
    List<ArticleModel>? articles,
    FormStatus? status,
  }) =>
      ArticleState(
        articleDetail: articleDetail ?? this.articleDetail,
        articleModel: articleModel ?? this.articleModel,
        articles: articles ?? this.articles,
        statusText: statusText ?? this.statusText,
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [
    articleModel,
    articles,
    statusText,
    status,
    articleDetail,
  ];

  bool canAddArticle() {
    if (articleModel.image.isEmpty) return false;
    if (articleModel.title.isEmpty) return false;
    if (articleModel.description.isEmpty) return false;
    return true;
  }
}