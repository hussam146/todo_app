import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }


  getData({required String? key}) {
    return sharedPreferences!.get(key!);
  }

  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    }
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    } else {
      return await sharedPreferences!.setDouble(key, value);
    }
  }

  removeData({required String key}) async {
    await sharedPreferences!.remove(key);
  }

  clearData() async {
    await sharedPreferences!.clear();
  }

  containsKey({required String key}) {
    return sharedPreferences!.containsKey(key);
  }
}
