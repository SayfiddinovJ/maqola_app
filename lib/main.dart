import 'package:columnist/cubits/article/article_cubit.dart';
import 'package:columnist/cubits/auth/auth_cubit.dart';
import 'package:columnist/cubits/profile/profile_cubit.dart';
import 'package:columnist/cubits/sites/sites_cubit.dart';
import 'package:columnist/cubits/tab/tab_cubit.dart';
import 'package:columnist/cubits/user/user_cubit.dart';
import 'package:columnist/data/local/shared_preference.dart';
import 'package:columnist/data/network/article_service.dart';
import 'package:columnist/data/network/auth_service.dart';
import 'package:columnist/data/network/profile_service.dart';
import 'package:columnist/data/network/site_service.dart';
import 'package:columnist/data/repositories/article_repository.dart';
import 'package:columnist/data/repositories/auth_repository.dart';
import 'package:columnist/data/repositories/profile_repository.dart';
import 'package:columnist/data/repositories/site_repository.dart';
import 'package:columnist/ui/auth/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();

  runApp(
    App(
      apiService: AuthService(),
      articleService: ArticleService(),
      profileService: ProfileService(),
      siteService: SiteService(),
    ),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.apiService,
    required this.articleService,
    required this.profileService,
    required this.siteService,
  });

  final AuthService apiService;
  final ArticleService articleService;
  final ProfileService profileService;
  final SiteService siteService;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) => AuthRepository(apiService: apiService)),
        RepositoryProvider(
            create: (context) =>
                ArticleRepository(articleService: articleService)),
        RepositoryProvider(
            create: (context) =>
                ProfileRepository(profileService: profileService)),
        RepositoryProvider(
            create: (context) =>
                SiteRepository(siteService: siteService)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ArticleCubit(
              articleRepository: context.read<ArticleRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(
              profileRepository: context.read<ProfileRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SiteCubit(
              siteRepository: context.read<SiteRepository>(),
            ),
          ),
          BlocProvider(create: (context) => UserCubit()),
          BlocProvider(create: (context) => TabCubit()),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
        );
      },
    );
  }
}
