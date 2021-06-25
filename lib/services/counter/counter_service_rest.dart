import '../../app/dependencies.dart';
import '../../models/counter.dart';
import '../../models/user.dart';
import '../rest.dart';
import 'counter_service.dart';

class CounterServiceRest implements CounterService {
  RestService get rest => dependency();

  Future<Counter> getCounterByUser(User user) async {
    final userId = user.id;
    // final List listJson = await rest.get('counters?user=$userId');
    final List listJson = await rest.get('counters/$userId');
    if (listJson == null || listJson.length == 0) return null;
    return Counter.fromJson(listJson[0]);
  }

  Future<Counter> updateCounter(Counter counter) async {
    final json = await rest.put('counters/${counter.id}', data: counter);
    return Counter.fromJson(json);
  }
}
