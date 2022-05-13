import 'package:data_layer/data_layer.dart';

class DummyService implements HealthService {
  @override
  bool getHealth() {
    return true;
  }
}
