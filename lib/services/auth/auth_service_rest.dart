import '../../app/dependencies.dart';
import '../../models/user.dart';
import '../rest.dart';
import 'auth_service.dart';

class AuthServiceRest implements AuthService {
  RestService get rest => dependency();

  Future<User> authenticate({String login, String password}) async {
    final List json = await rest.get('users?login=$login&&password=$password');
    if (json == null || json.length == 0) return null;

    final _user = User.fromJson(json[0]);
    return _user;
  }
}
