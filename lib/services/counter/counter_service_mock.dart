import '../../models/counter.dart';
import 'counter_service.dart';

class CounterServiceMock implements CounterService {
  Future<Counter> getCounterByUser(dynamic userId) async {
    Counter _counter = _counters.firstWhere((counter) => counter.user == userId,
        orElse: () => null);
    return _counter;
  }

  Future<Counter> updateCounter(Counter counter) async {
    return Counter.copy(counter);
  }
}

final _counters = <Counter>[
  Counter(id: 1, user: 1, counter: 10),
  Counter(id: 2, user: 2, counter: 20),
];
