import '../../models/counter.dart';

abstract class CounterService {
  Future<Counter> getCounterByUser(int userId);
  Future<Counter> updateCounter(Counter counter);
}
