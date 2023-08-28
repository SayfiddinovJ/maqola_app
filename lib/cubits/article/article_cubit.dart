import 'package:columnist/cubits/article/article_state.dart';
import 'package:columnist/data/models/articles/article_fields.dart';
import 'package:columnist/data/models/articles/article_model.dart';
import 'package:columnist/data/models/universal_data.dart';
import 'package:columnist/data/repositories/article_repository.dart';
import 'package:columnist/data/status.dart';
import 'package:columnist/utils/ui_utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleCubit extends Cubit<ArticleState> {
  ArticleCubit({required this.articleRepository})
      : super(
          ArticleState(
            articleModel: ArticleModel(
                artId: 0,
                image: '',
                title: '',
                description: '',
                likes: '',
                views: '',
                addDate: '',
                username: '',
                avatar: '',
                profession: '',
                userId: 0),
            articles: const [],
          ),
        );

  final ArticleRepository articleRepository;

  createArticle() async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
        statusText: "",
      ),
    );
    UniversalData response = await articleRepository.createArticle(state.articleModel);
    if (response.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          statusText: "article_added",
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          statusText: response.error,
        ),
      );
    }
  }

  getAllArticles(BuildContext context) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
        statusText: "",
      ),
    );
    showLoading(context: context);
    UniversalData response = await articleRepository.getAllArticles();
    if (context.mounted) hideLoading(loadingContext: context);
    if (response.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          statusText: "get_articles",
          articles: response.data as List<ArticleModel>,
        ),
      );
    } else {
      emit(state.copyWith(
        status: FormStatus.failure,
        statusText: response.error,
      ));
    }
  }

  getArticleById(int id) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
        statusText: "",
      ),
    );
    UniversalData response = await articleRepository.getArticleById(id);
    if (response.error.isEmpty) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          statusText: "get_article_by_id",
          articleDetail: response.data as ArticleModel,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          statusText: response.error,
        ),
      );
    }
  }

  updateArticleField({
    required ArticleField field,
    required dynamic value,
  }) {
    ArticleModel currentArticle = state.articleModel;

    switch (field) {
      case ArticleField.title:
        {
          currentArticle = currentArticle.copyWith(title: value as String);
          break;
        }
      case ArticleField.description:
        {
          currentArticle = currentArticle.copyWith(description: value as String);
          break;
        }
      case ArticleField.image:
        {
          print('Value: $value');
          currentArticle = currentArticle.copyWith(image: value as String);
          break;
        }
    }

    debugPrint("Article: ${currentArticle.toString()}");

    emit(state.copyWith(articleModel: currentArticle, status: FormStatus.pure));
  }
}
