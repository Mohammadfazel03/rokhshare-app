import 'package:shared_preferences/shared_preferences.dart';

enum LocalStorageKey {
  isLogin("isLogin"),
  isPremium("isPremium"),
  days("days"),
  email("email"),
  username("username"),
  accessToken("accessToken"),
  theme("theme"),
  refreshToken("refreshToken");

  final String key;

  const LocalStorageKey(this.key);
}

class LocalStorageService {
  final SharedPreferencesAsync _preferences;
  final Map<String, Object?> _cache;

  LocalStorageService({required SharedPreferencesAsync preferences})
      : _preferences = preferences,
        _cache = {};

  Future<void> login(String accessToken, String refreshToken, bool isPremium,
      int? days, String email, String username) async {
    _cache.clear();
    await _preferences.setBool(LocalStorageKey.isLogin.key, true);
    await _preferences.setString(
        LocalStorageKey.refreshToken.key, refreshToken);
    await _preferences.setString(LocalStorageKey.accessToken.key, accessToken);
    await _preferences.setString(LocalStorageKey.email.key, email);
    await _preferences.setString(LocalStorageKey.username.key, username);
    await _preferences.setBool(LocalStorageKey.isPremium.key, isPremium);
    if (days != null) {
      await _preferences.setInt(LocalStorageKey.days.key, days);
    }
  }

  Future<void> setPremium(int days) async {
    _cache.clear();
    await _preferences.setBool(LocalStorageKey.isPremium.key, true);
    await _preferences.setInt(LocalStorageKey.days.key, days);
  }

  Future<void> updateAccessToken(String accessToken) async {
    _cache.remove(LocalStorageKey.accessToken.key);
    await _preferences.setString(LocalStorageKey.accessToken.key, accessToken);
  }

  Future<void> logout() async {
    _cache.remove(LocalStorageKey.accessToken.key);
    _cache.remove(LocalStorageKey.refreshToken.key);
    _cache.remove(LocalStorageKey.email.key);
    _cache.remove(LocalStorageKey.username.key);
    _cache.remove(LocalStorageKey.days.key);
    _cache.remove(LocalStorageKey.isPremium.key);
    _cache.remove(LocalStorageKey.isLogin.key);
    await _preferences.remove(LocalStorageKey.accessToken.key);
    await _preferences.remove(LocalStorageKey.refreshToken.key);
    await _preferences.remove(LocalStorageKey.email.key);
    await _preferences.remove(LocalStorageKey.username.key);
    await _preferences.remove(LocalStorageKey.days.key);
    await _preferences.remove(LocalStorageKey.isPremium.key);
    await _preferences.setBool(LocalStorageKey.isLogin.key, false);
  }

  Future<String?> getAccessToken() async {
    if (_cache.containsKey(LocalStorageKey.accessToken.key)) {
      return (_cache[LocalStorageKey.accessToken.key]) as String?;
    }
    var token = await _preferences.getString(LocalStorageKey.accessToken.key);
    if (token != null) {
      _cache[LocalStorageKey.accessToken.key] = token;
    }
    return token;
  }

  Future<String?> getRefreshToken() async {
    if (_cache.containsKey(LocalStorageKey.refreshToken.key)) {
      return (_cache[LocalStorageKey.refreshToken.key]) as String?;
    }
    var token = await _preferences.getString(LocalStorageKey.refreshToken.key);
    if (token != null) {
      _cache[LocalStorageKey.refreshToken.key] = token;
    }
    return token;
  }

  Future<bool?> isLogin() async {
    if (_cache.containsKey(LocalStorageKey.isLogin.key)) {
      return (_cache[LocalStorageKey.isLogin.key]) as bool?;
    }
    var res = await _preferences.getBool(LocalStorageKey.isLogin.key);
    if (res != null) {
      _cache[LocalStorageKey.isLogin.key] = res;
    }
    return res;
  }

  Future<int?> getDays() async {
    if (_cache.containsKey(LocalStorageKey.days.key)) {
      return (_cache[LocalStorageKey.days.key]) as int?;
    }
    var res = await _preferences.getInt(LocalStorageKey.days.key);
    if (res != null) {
      _cache[LocalStorageKey.days.key] = res;
    }
    return res;
  }

  Future<bool?> isPremium() async {
    if (_cache.containsKey(LocalStorageKey.isPremium.key)) {
      return (_cache[LocalStorageKey.isPremium.key]) as bool?;
    }
    var res = await _preferences.getBool(LocalStorageKey.isPremium.key);
    if (res != null) {
      _cache[LocalStorageKey.isPremium.key] = res;
    }
    return res;
  }

  Future<String?> getEmail() async {
    if (_cache.containsKey(LocalStorageKey.email.key)) {
      return (_cache[LocalStorageKey.email.key]) as String?;
    }
    var res = await _preferences.getString(LocalStorageKey.email.key);
    if (res != null) {
      _cache[LocalStorageKey.email.key] = res;
    }
    return res;
  }

  Future<String?> getUsername() async {
    if (_cache.containsKey(LocalStorageKey.username.key)) {
      return (_cache[LocalStorageKey.username.key]) as String?;
    }
    var res = await _preferences.getString(LocalStorageKey.username.key);
    if (res != null) {
      _cache[LocalStorageKey.username.key] = res;
    }
    return res;
  }

  Future<bool?> isDark() async {
    if (_cache.containsKey(LocalStorageKey.theme.key)) {
      return (_cache[LocalStorageKey.theme.key]) as bool?;
    }
    var res = await _preferences.getBool(LocalStorageKey.theme.key);
    if (res != null) {
      _cache[LocalStorageKey.theme.key] = res;
    }
    return res;
  }

  Future<void> setThemeMode(bool isDark) async {
    await _preferences.setBool(LocalStorageKey.theme.key, isDark);
  }
}
