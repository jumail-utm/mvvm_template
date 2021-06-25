import '../../app/dependencies.dart';
import '../../models/user.dart';
import '../rest.dart';
import 'auth_service.dart';

class AuthServiceSecuredRest implements AuthService {
  RestService get rest => dependency();

  Future<User> authenticate({String login, String password}) async {
    try {
      final json = await rest
          .post('auths/signin', data: {'email': login, 'password': password});

      if (json == null) return null;

      // Pre-process json data to comply with the field of the User model
      json['id'] = json['localId'];
      json['name'] = json['displayName'];
      json['photoUrl'] = json['profilePicture'];

      // Get the access token and let the rest object stores that
      rest.openSession(json['idToken']);

      final _user = User.fromJson(json);
      return _user;
    } catch (e) {
      return null;
    }
  }

  Future<void> signout() async => rest.closeSession();
}
