import '../../models/counter.dart';
import '../../models/user.dart';

abstract class CounterService {
  Future<Counter> getCounterByUser(User user);
  Future<Counter> updateCounter(Counter counter);
}
