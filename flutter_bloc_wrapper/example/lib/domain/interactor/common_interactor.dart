
import 'package:example_flutter_bloc_wrapper/data/data.dart';
import 'package:example_flutter_bloc_wrapper/domain/pojo/user.dart';

class CommonInteractor {
  Future<User> login(String userName, String password) async {
    return api.authenticate(userName: userName, password: password);
  }

}
