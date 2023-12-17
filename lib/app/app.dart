import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/features/task/presentation/cubit/task_states.dart';
import '../core/themes/app_theme.dart';
import '../features/auth/presentation/cubit/on_boarding_cubit.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/task/presentation/cubit/task_cubit.dart';

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => OnBoardingCubit()),
            BlocProvider(create: (context) => TaskCubit()..getTasks()..changeTheme(fromShared: isDark))
          ],
          child: BlocBuilder<TaskCubit, TaskStates>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: TaskCubit.get(context).isDark?getDarkTheme(context) : getLightTheme(context),
                home: const SplashScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
