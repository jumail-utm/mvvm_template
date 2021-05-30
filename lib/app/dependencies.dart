import 'package:get_it/get_it.dart';

import '../services/rest.dart';
import '../screens/user/user_viewmodel.dart';

import '../services/auth/auth_service.dart';
import '../services/counter/counter_service.dart';

import '../services/auth/auth_service_rest.dart';
import '../services/counter/counter_service_rest.dart';

// import '../services/auth/auth_service_mock.dart';
// import '../services/counter/counter_service_mock.dart';

GetIt dependency = GetIt.instance;

void init() {
  // Services
  dependency.registerLazySingleton<RestService>(
    () => RestService(baseUrl: 'http://192.168.0.5:3000'),
  );

  dependency.registerLazySingleton<CounterService>(() => CounterServiceRest());
  dependency.registerLazySingleton<AuthService>(() => AuthServiceRest());
  // dependency.registerLazySingleton<CounterService>(() => CounterServiceMock());
  // dependency.registerLazySingleton<AuthService>(() => AuthServiceMock());

  // Viewmodels
  dependency.registerLazySingleton(() => UserViewmodel());
}
