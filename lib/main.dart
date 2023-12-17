import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/bloc_observer.dart';
import '../../../../core/database/cache_helper.dart';
import '../../../../core/database/sqflite_helper.dart';
import '../../../../core/services/notifications_services.dart';
import 'app/app.dart';
import 'core/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  setUp(); // locate get_it instances
  await sl<CacheHelper>().init();
  sl<SqfliteHelper>().initDatabase();
  await sl<NotifyHelper>().initializeNotification(sl<NotifyHelper>().fln);
  Bloc.observer = MyBlocObserver();
  bool? isDark = await CacheHelper().getData(key: 'is-dark') ?? false;
  runApp(MyApp(isDark));
}
