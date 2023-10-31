import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/themes/app_theme.dart';
import '../features/auth/presentation/cubit/on_boarding_cubit.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/task/presentation/cubit/task_cubit.dart';

class MyApp extends StatelessWidget {
  // singleton instance
  const MyApp._internal();
  static const MyApp instance = MyApp._internal();
  factory MyApp() => instance;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => OnBoardingCubit()),
            BlocProvider(create: (context) => TaskCubit()..getTasks())
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getTheme(context),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
