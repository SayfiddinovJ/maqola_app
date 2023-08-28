import 'package:columnist/data/models/articles/article_model.dart';
import 'package:columnist/data/models/universal_data.dart';
import 'package:columnist/data/network/article_service.dart';

class ArticleRepository {
  final ArticleService articleService;

  ArticleRepository({required this.articleService});

  Future<UniversalData> getAllArticles() async =>
      await articleService.getAllArticles();

  Future<UniversalData> getArticleById(int id) async =>
      await articleService.getArticleById(id);

  Future<UniversalData> createArticle(ArticleModel articleModel) async =>
      await articleService.createArticle(articleModel: articleModel);
}
