import 'package:alchef/core/service/hive_service.dart';
import 'package:alchef/features/auth/model/auth_response.dart';
import 'package:alchef/routes/app_router.dart';
import 'package:alchef/routes/route_paths.dart';

class AuthHelper {
  static const String _userKey = 'user';

  static Future<void> saveUserData(User data) async {
    await HiveService.write(_userKey, data.toJson());
  }

  static User get user {
    final detail = HiveService.read(_userKey) ?? {};

    final cleanJson = deepCast(detail) as Map<String, dynamic>;
    return User.fromJson(cleanJson);
  }


  static int get userId => user.id;

  static bool get isProfileUpdated => user.step > 0;

  static String get authToken => user.userAuthToken;

    static bool get isLoggedIn => authToken.isNotEmpty;


  static Future<void> logoutUser({String? message}) async {
    await HiveService.deleteAll();
    appRouter.go(RoutePaths.splash);
  }
}

dynamic deepCast(dynamic value) {
  if (value is Map) {
    return value.map((key, val) => MapEntry(key.toString(), deepCast(val)));
  } else if (value is List) {
    return value.map(deepCast).toList();
  }
  return value;
}
