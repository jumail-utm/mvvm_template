import '../../app/dependencies.dart';
import '../../models/counter.dart';
import '../../models/user.dart';
import '../rest.dart';
import 'counter_service.dart';

class CounterServiceSecuredRest implements CounterService {
  RestService get rest => dependency();

  Future<Counter> getCounterByUser(User user) async {
    final json = await rest.get('counters/${user.id}');
    if (json == null) return null;
    json['id'] = user
        .id; // db design in Firestore:  counter.id is user.id == counter.user
    return Counter.fromJson(json);
  }

  // db design in Firestore:  counter.id is user.id == counter.user
  Future<Counter> updateCounter(Counter counter) async {
    final json = await rest.put('counters/${counter.id}', data: counter);
    return Counter.fromJson(json);
  }
}
