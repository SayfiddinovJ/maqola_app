import 'package:columnist/cubits/auth/auth_cubit.dart';
import 'package:columnist/data/local/shared_preference.dart';
import 'package:columnist/data/network/api_service.dart';
import 'package:columnist/data/repositories/auth_repository.dart';
import 'package:columnist/ui/auth/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();

  runApp(App(apiService: ApiService(),));
}

class App extends StatelessWidget {
  const App({super.key, required this.apiService});
  final ApiService apiService;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context)=>AuthRepository(apiService: apiService))
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(create: (context)=>AuthCubit(authRepository: context.read<AuthRepository>()))
      ], child: const MyApp()),
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