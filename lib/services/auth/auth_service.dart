import '../../models/user.dart';

abstract class AuthService {
  Future<User> authenticate({String login, String password});
}
