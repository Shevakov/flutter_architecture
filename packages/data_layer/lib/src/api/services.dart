import 'package:domain_module/domain_module.dart';

abstract class HealthService {
  bool getHealth();
}

abstract class UserService {
  Future<UserData> getDefaultUser();
  Future<UserData> getUserById(int id);
}
