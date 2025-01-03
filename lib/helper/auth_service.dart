import 'package:projectlab/models/user.dart';

class AuthService {
  static User? loggedUser;

  static void setUser(User user) {
    loggedUser = user;
  }

  static String get username => loggedUser?.username ?? 'Guest';

  static String get role => loggedUser?.role ?? 'user';

  static void logout() {
    loggedUser = null;
  }
}
