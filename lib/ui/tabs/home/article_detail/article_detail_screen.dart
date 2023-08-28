import 'package:cached_network_image/cached_network_image.dart';
import 'package:columnist/cubits/article/article_cubit.dart';
import 'package:columnist/cubits/article/article_state.dart';
import 'package:columnist/data/models/articles/article_model.dart';
import 'package:columnist/data/status.dart';
import 'package:columnist/utils/app_colors.dart';
import 'package:columnist/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen(
      {super.key,
      required this.id,
      required this.username,
      required this.avatar});

  final int id;
  final String username;
  final String avatar;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  _init() {
    BlocProvider.of<ArticleCubit>(context).getArticleById(widget.id);
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Text(widget.username),
        actions: [
          CircleAvatar(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: baseUrl + widget.avatar.substring(1),
                height: 40.h,
                width: 40.h,
                errorWidget: (e1, e2, e3) => Icon(
                  Icons.account_circle_rounded,
                  size: 40.h,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: BlocBuilder<ArticleCubit, ArticleState>(
        builder: (context, state) {
          if (state.status == FormStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          ArticleModel? article = state.articleDetail;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.articleDetail!.title,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 10.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                    ),
                    height: 300.h,
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      imageUrl: baseUrl + article!.image.substring(1),
                      fit: BoxFit.fill,
                      errorWidget: (e1, e2, e3) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey,
                        ),
                        height: 250.h,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error,
                              size: 100.h,
                            ),
                            const Text('Image not found'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  article.description,
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 0.16.sp,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: const Color(0xFF616161),
                ),
                SizedBox(height: 12.h),
                Text(
                  '${article.views} Views • ${article.likes} Likes',
                  style: TextStyle(
                    color: const Color(0xFF616161),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.32.sp,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
