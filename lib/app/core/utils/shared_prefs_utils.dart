import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtil {
  static SharedPreferences? instance;

  static Future init() async {
    instance = await SharedPreferences.getInstance();
  }

  bool getBool(String key) => instance!.getBool(key) ?? false;
  void setBool(String key, bool value) => instance!.setBool(key, value);
}
