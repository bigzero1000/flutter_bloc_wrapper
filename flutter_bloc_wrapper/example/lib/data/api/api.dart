import 'package:example_flutter_bloc_wrapper/domain/pojo/user.dart';
import 'package:meta/meta.dart';

abstract class Api {

  Future<User> authenticate({
    @required String userName,
    @required String password,
  });

}
