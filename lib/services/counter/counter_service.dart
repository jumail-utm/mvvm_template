import '../../models/counter.dart';

abstract class CounterService {
  Future<Counter> getCounterByUser(dynamic userId);
  Future<Counter> updateCounter(Counter counter);
}
