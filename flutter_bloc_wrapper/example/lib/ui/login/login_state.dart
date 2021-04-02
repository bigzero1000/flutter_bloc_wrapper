import 'package:flutter_bloc_wrapper/flutter_bloc_wrapper.dart';

class LoginDataState extends ScreenDataState {
  final bool isInit;
  final bool isLoading;
  final bool isLoginSuccess;
  final String errorCodeUserName;
  final String errorCodePassword;

  const LoginDataState({this.isInit, this.isLoading, this.isLoginSuccess, this.errorCodePassword = "", this.errorCodeUserName = ""});

  LoginDataState copy({bool isInit, bool isLoading, bool isLoginSuccess, String errorCodePassword, String errorCodeUserName}) {
    return LoginDataState(
        isInit: isInit ?? this.isInit,
        isLoading: isLoading ?? this.isLoading,
        isLoginSuccess: isLoginSuccess ?? false,
        errorCodePassword: errorCodePassword ?? '',
        errorCodeUserName: errorCodeUserName ?? '');
  }

  const LoginDataState.init()
      : isInit = true,
        isLoading = false,
        isLoginSuccess = false,
        errorCodeUserName = '',
        errorCodePassword = '';
}
