import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static late SharedPreferences _sharedPrefs;

   Future init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }
  Future<bool> shouldUpdate() async {
    final savedTimestamp = _sharedPrefs.getInt('timestamp');
    if (savedTimestamp == null) {
      await _sharedPrefs.setInt('timestamp', DateTime.now().millisecondsSinceEpoch);
      return true;
    } else {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final difference = currentTime - savedTimestamp;
      if (difference > 30 * 60 * 1000) {
        await _sharedPrefs.setInt('timestamp', currentTime);
        return true;
      } else {
        return false;
      }
    }
  }
}
