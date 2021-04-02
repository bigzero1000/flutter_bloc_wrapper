import 'package:flutter_bloc_wrapper/flutter_bloc_wrapper.dart';
import 'package:meta/meta.dart';


abstract class LoginEvent extends ScreenEvent{
  const LoginEvent();
}

class LoginButtonPressedEvent extends LoginEvent {
  final String userName;
  final String password;

  const LoginButtonPressedEvent({
    @required this.userName,
    @required this.password,
  });

}
