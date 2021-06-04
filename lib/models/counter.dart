class Counter {
  dynamic
      _id; // Use dynamic type because json-server id is int and firestore id is string
  dynamic _user;
  int _counter;

// ignore: unnecessary_getters_setters
  get id => _id;
  // ignore: unnecessary_getters_setters
  set id(value) => _id = value;

  // ignore: unnecessary_getters_setters
  get user => _user;
  // ignore: unnecessary_getters_setters
  set user(value) => _user = value;

  get counter => _counter;
  set counter(value) => _counter = value;

  Counter({int counter = 0, dynamic id, dynamic user})
      : _counter = counter,
        _id = id,
        _user = user;

  Counter.copy(Counter from)
      : this(counter: from._counter, id: from.id, user: from.user);

  Counter.fromJson(Map<String, dynamic> json)
      : this(
          counter: json['counter'],
          id: json['id'],
          user: json['user'],
        );

  Map<String, dynamic> toJson() => {
        'counter': counter,
        'id': id,
        'user': user,
      };
}
