import '../../models/user.dart';
import 'auth_service.dart';

class AuthServiceMock implements AuthService {
  Future<User> authenticate({String login, String password}) async {
    User _user = _users.firstWhere(
        (user) => user.login == login && user.password == password,
        orElse: () => null);
    return _user;
  }
}

final _users = <User>[
  User(
      id: 1,
      login: 'hello',
      name: 'Testing User',
      password: 'world',
      photoUrl: 'https://randomuser.me/api/portraits/thumb/men/75.jpg'),
  User(
      id: 2,
      login: 'user2',
      name: 'Testing User 2',
      password: '123',
      photoUrl: 'https://randomuser.me/api/portraits/thumb/women/75.jpg'),
];
