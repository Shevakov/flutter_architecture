import 'package:business_layer/business_layer.dart';
import 'package:data_layer/data_layer.dart';
import 'package:get_it/get_it.dart';

class BlocFactory {
  static final _getIt = GetIt.I;

  T get<T extends Object>() => _getIt.get<T>();

  static final instance = BlocFactory();

  void initialize() {
    ServiceProvider.instance.initialize();
    _getIt.registerFactory<MainBloc>(
      () => MainBloc(
          healthService: ServiceProvider.instance.get<HealthService>()),
    );
  }
}
