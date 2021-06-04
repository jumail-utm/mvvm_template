class User {
  dynamic
      _id; // Use dynamic type because json-server id is int and firestore id is string
  String _name;
  String _photoUrl;
  String _login;
  String _password;

  // ignore: unnecessary_getters_setters
  get id => _id;
  // ignore: unnecessary_getters_setters
  set id(value) => _id = value;

  get name => _name;
  set name(value) => _name = value;

  get photoUrl => _photoUrl;
  set photoUrl(value) => _photoUrl = value;

  get login => _login;
  set login(value) => _login = value;

  get password => _password;
  set password(value) => _password = value;

  User(
      {dynamic id,
      String name = '',
      String photoUrl = '',
      String login = '',
      String password = ''})
      : _id = id,
        _name = name,
        _photoUrl = photoUrl,
        _login = login,
        _password = password;
  User.copy(User from)
      : this(
            id: from.id,
            name: from.name,
            photoUrl: from.photoUrl,
            login: from.login,
            password: from.password);

  User.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          photoUrl: json['photoUrl'],
          login: json['login'],
          password: json['password'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'photoUrl': photoUrl,
        'login': login,
        'password': password,
      };
}
