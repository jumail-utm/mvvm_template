import '../../app/dependencies.dart';
import '../../services/counter/counter_service.dart';
import '../../models/user.dart';
import '../../models/counter.dart';
import '../user/user_viewmodel.dart';
import '../viewmodel.dart';

class MainViewmodel extends Viewmodel {
  UserViewmodel get _userViewmodel => dependency();
  User get user => _userViewmodel.user;
  set user(User value) {
    _userViewmodel.user = value;
    if (_userViewmodel.isUserSignedIn)
      loadUserCounter();
    else
      update(() async {});
  }

  void authenticate(User user) =>
      update(() async => _userViewmodel.authenticate(user));

  bool get isUserSignedIn => _userViewmodel.isUserSignedIn;

  CounterService get service => dependency();
  Counter _counter;
  get counter => _counter;

  void loadUserCounter() =>
      update(() async => _counter = await service.getCounterByUser(user.id));

  // synchronizer methods
  void increaseCounter() => update(() async {
        _counter.counter = _counter.counter + 1;
        await service.updateCounter(_counter);
      });
}
