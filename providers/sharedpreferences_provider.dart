import 'package:shared_preferences/shared_preferences.dart';
import 'package:guatini/global/tools.dart' as tools;

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._();

  UserPreferences._();

  factory UserPreferences() {
    return _instance;
  }

  SharedPreferences? _userPreferences;

  initPrefs() async {
    _userPreferences = await SharedPreferences.getInstance();
  }

  String? get dbPath {
    return _userPreferences!.getString(tools.keyDBPath);
  }

  set dbPath(String? value) =>
      _userPreferences!.setString(tools.keyDBPath, value!);
}
