import 'package:shared_preferences/shared_preferences.dart';
import 'package:guatini/global/tools.dart' as tools;

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._();

  UserPreferences._();

  factory UserPreferences() => _instance;

  SharedPreferences? _userPreferences;

  initPrefs() async {
    _userPreferences = await SharedPreferences.getInstance();
  }

  String? get dbPath => _userPreferences!.getString(tools.keyDBPath);

  set dbPath(String? value) =>
      _userPreferences!.setString(tools.keyDBPath, value!);

  List<String>? get last5Searches {
    return _userPreferences!.getStringList(tools.keyLastSearches) ?? [];
  }

  newSearch(String newSearch) {
    List<String> _list = last5Searches!;
    if (_list.contains(newSearch)) {
      _list.remove(newSearch);
    }
    _list.add(newSearch);
    if (_list.length > 5) {
      _list.removeAt(0);
    }
    _userPreferences!.setStringList(tools.keyLastSearches, _list);
  }
}
