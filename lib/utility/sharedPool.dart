import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SharedPool {
//get frequently emoji in SharedPreferences (json string)
  static Future<String> getRecent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(cat_recent);
  }

// save frequently emoji in SharedPreferences (json string)
  static saveRecent(value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(cat_recent, value);
  }
}
