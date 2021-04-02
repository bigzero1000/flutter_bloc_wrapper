import 'dart:async';

import 'package:example_flutter_bloc_wrapper/domain/domain.dart';
import 'package:example_flutter_bloc_wrapper/ui/app/app.dart';
import 'package:example_flutter_bloc_wrapper/ui/app/app_event.dart';
import 'package:example_flutter_bloc_wrapper/ui/login/login_event.dart';
import 'package:example_flutter_bloc_wrapper/ui/login/login_state.dart';
import 'package:flutter_bloc_wrapper/flutter_bloc_wrapper.dart';

class LoginEventProcessor
    extends EventToStateProcessor<LoginEvent, LoginDataState> {
  LoginEventProcessor(LoginDataState initialState) : super(initialState);

  // @override
  // LoginDataState get initialState =>

  @override
  Stream<LoginDataState> processEvent(LoginEvent event) async* {
    if (event is LoginButtonPressedEvent) {
      yield currentState.copy(isInit: false, isLoading: true);
      var errorCodeUserName = '';
      var errorCodePassword = '';
      if (event.userName.isEmpty) {
        errorCodeUserName = 'user_name_empty';
      }
      if (event.password.isEmpty) {
        errorCodePassword = 'pass_empty';
      }
      if (errorCodeUserName.isNotEmpty || errorCodePassword.isNotEmpty) {
        yield currentState.copy(
            isLoading: false,
            errorCodeUserName: errorCodeUserName,
            errorCodePassword: errorCodePassword);
      } else {
        final userResponded =
            await commonInteractor.login(event.userName, event.password);
        if (userResponded != null) {
          appEventProcessor.raiseEvent(LoggedIn());
          yield currentState.copy(
              isInit: false, isLoading: false, isLoginSuccess: true);
        }
      }
    }
  }
}
