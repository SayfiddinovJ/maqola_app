import 'package:cached_network_image/cached_network_image.dart';
import 'package:columnist/cubits/article/article_cubit.dart';
import 'package:columnist/cubits/article/article_state.dart';
import 'package:columnist/data/models/articles/article_model.dart';
import 'package:columnist/data/status.dart';
import 'package:columnist/ui/tabs/home/article_detail/article_detail_screen.dart';
import 'package:columnist/utils/app_colors.dart';
import 'package:columnist/utils/app_icons.dart';
import 'package:columnist/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _init() {
    Future.microtask(
        () => BlocProvider.of<ArticleCubit>(context).getAllArticles(context));
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
        title: Center(
          child: SvgPicture.asset(AppIcons.smallLogo),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: BlocBuilder<ArticleCubit, ArticleState>(
        builder: (context, state) {
          if (state.status == FormStatus.failure) {
            return Center(
              child: Text(
                state.statusText,
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.16.sp,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(height: 8.h),
              ...List.generate(
                state.articles.length,
                (index) {
                  ArticleModel article = state.articles[index];
                  debugPrint(article.image);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleDetailScreen(
                            id: article.artId,
                            username: article.username, avatar: article.avatar,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      height: 36.h,
                                      width: 36.h,
                                      imageUrl:
                                          baseUrl + article.avatar.substring(1),
                                      errorWidget: (e1, e2, e3) => const Icon(
                                          Icons.account_circle_rounded,
                                          size: 36),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Text(
                                    article.username,
                                    style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 0.16.sp,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  SvgPicture.asset(
                                    AppIcons.tick,
                                    height: 17.h,
                                    width: 17.h,
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                article.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 0.16.sp,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 8.w),
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
                                    imageUrl:
                                        baseUrl + article.avatar.substring(1),
                                    fit: BoxFit.fill,
                                    errorWidget: (e1, e2, e3) => Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey,
                                      ),
                                      height: 250.h,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: const Color(0xFF616161),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
