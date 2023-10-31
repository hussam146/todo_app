import 'package:flutter_local_notifications/flutter_local_notifications.dart';


// Notify on android only.

class NotifyHelper {
  FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();

  // call it in our build start.
  Future initializeNotification(FlutterLocalNotificationsPlugin fln) async {
    // logo for our notification.
    // android/app/src/main/res/icon.png. (example).
    var androidInit = const AndroidInitializationSettings('drawable/icon');
    // applied in android devices only.
    var initSettings = InitializationSettings(android: androidInit);
    await fln.initialize(initSettings);
  }

  Future<void> showNotification({
    required String title,
    required String body,
    var id = 0,
    required FlutterLocalNotificationsPlugin fln,
  }) async {
    var androidDetails = const AndroidNotificationDetails(
      'not_channel 5', // as i want --> channel id.
      'id1', // as i want  --> channel name.
      playSound: true,
      // android/app/src/main/res/raw/notification.wav ---- (raw dir creartion is your work).
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );

    var notDetails = NotificationDetails(android: androidDetails);
    await fln.show(0, title, body, notDetails);
  }
}


/*

    <meta-data
      android:name="com.google.firebase.messaging.default_notification_channel_id"
      android:value="not_channel 5"
    />



    <intent-filter>
      <action android:name="FLUTTER_NOTIFICATION_CLICK" />
      <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>

    android/app/build.gradle
    coreLibraryDesugaringEnabled true  -> compileOptions
    multiDexEnabled true -> defaultConfig
    coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:1.1.5' -> dependencies
    compileSdkVersion 33 

 */