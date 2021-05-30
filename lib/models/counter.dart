class Counter {
  int _id;
  int _user;
  int _counter;

  get id => _id;
  set id(value) => _id = value;

  get user => _user;
  set user(value) => _user = value;

  get counter => _counter;
  set counter(value) => _counter = value;

  Counter({int counter = 0, int id, int user})
      : _counter = counter,
        _id = id,
        _user = user;

  Counter.copy(Counter from)
      : this(counter: from._counter, id: from.id, user: from.user);

  Counter.fromJson(Map<String, dynamic> json)
      : this(
          counter: json['counter'] ?? '',
          id: json['id'] ?? 0,
          user: json['user'] ?? 0,
        );

  Map<String, dynamic> toJson() => {
        'counter': counter,
        'id': id,
        'user': user,
      };
}
