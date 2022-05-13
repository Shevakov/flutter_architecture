import 'package:data_layer/data_layer.dart';
import 'package:get_it/get_it.dart';

class ServiceProvider {
  static final _getIt = GetIt.I;

  get async => null;

  T get<T extends Object>() => _getIt.get<T>();

  static final instance = ServiceProvider();

  void initialize() {
    _getIt.registerLazySingleton<HealthService>(() => DummyService());
  }
}
