import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app/core/database/cache_helper.dart';
import 'package:todo_app/core/database/sqflite_helper.dart';
import 'package:todo_app/core/services/notifications_services.dart';

final sl = GetIt.instance;

void setUp() {
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper());
  sl.registerLazySingleton<SqfliteHelper>(() => SqfliteHelper());
  sl.registerLazySingleton<NotifyHelper>(() => NotifyHelper());
  sl.registerLazySingleton<AndroidFlutterLocalNotificationsPlugin>(
      () => AndroidFlutterLocalNotificationsPlugin());
}
