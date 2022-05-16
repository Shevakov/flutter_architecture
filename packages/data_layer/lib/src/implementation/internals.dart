import 'package:data_layer/data_layer.dart';
import 'package:domain_module/domain_module.dart';

class DummyService implements HealthService {
  @override
  bool getHealth() {
    return true;
  }
}

class DummyUserService implements UserService {
  @override
  Future<UserData> getDefaultUser() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    return const UserData(id: 1, name: 'Name');
  }

  @override
  Future<UserData> getUserById(int id) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    return UserData(
      id: id,
      name: 'Number $id',
    );
  }
}
