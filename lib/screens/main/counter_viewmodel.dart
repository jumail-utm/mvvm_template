import '../../app/dependencies.dart';
import '../../services/counter/counter_service.dart';
import '../../models/user.dart';
import '../../models/counter.dart';
import '../viewmodel.dart';
import 'main_viewmodel.dart';

class CounterViewmodel extends Viewmodel {
  final MainViewmodel _mainViewmodel;
  CounterViewmodel({mainViewmodel}) : _mainViewmodel = mainViewmodel {
    _loadUserCounter();
  }

  CounterService get service => dependency();
  Counter _counter;
  get counter => _counter;
  User get user => _mainViewmodel.user;

  void _loadUserCounter() =>
      update(() async => _counter = await service.getCounterByUser(user.id));

  // synchronizer methods
  void increaseCounter() => update(() async {
        _counter.counter = _counter.counter + 1;
        await service.updateCounter(_counter);
      });
}
