import 'package:example_flutter_bloc_wrapper/ui/app/translation.dart';
import 'package:example_flutter_bloc_wrapper/ui/login/login_event.dart';
import 'package:example_flutter_bloc_wrapper/ui/login/login_event_processor.dart';
import 'package:example_flutter_bloc_wrapper/ui/login/login_state.dart';
import 'package:example_flutter_bloc_wrapper/ui/util.dart';
import 'package:example_flutter_bloc_wrapper/ui/view_common/common_button.dart';
import 'package:example_flutter_bloc_wrapper/ui/view_common/common_require_indicator_label.dart';
import 'package:example_flutter_bloc_wrapper/ui/view_common/common_text_field_with_warning.dart';
import 'package:example_flutter_bloc_wrapper/ui/view_common/loading_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_wrapper/flutter_bloc_wrapper.dart';

class LoginScreen
    extends CoreScreen<LoginEvent, LoginDataState, LoginEventProcessor> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void handleDataStateChange(BuildContext context,
      LoginEventProcessor processor, LoginDataState state) {
    if (state.isLoginSuccess) {
      // Go to Home Screen
      // Navigator.pop(context);
    }
  }

  @override
  LoginEventProcessor createEventProcessor(LoginDataState state) {
    return LoginEventProcessor(state);
  }

  @override
  Widget buildScreen(BuildContext context, LoginEventProcessor processor,
      LoginDataState state) {
    return Scaffold(
        body: Stack(children: [
      GestureDetector(
        onTap: () => hiddenKeyboard(context),
        child: Container(
            color: const Color(0xffF5F0E8),
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 50, right: 20),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.only(bottom: 18, top: 6),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: <Widget>[
                          _viewHeader(
                              Translations.of(context).text("user_name_title"),
                              state.errorCodePassword.isEmpty),
                          TextFieldWarning(
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                            controller: _userNameController,
                            maxLength: 20,
                            errorCode: state.errorCodeUserName,
                          ),
                          _viewHeader(
                              Translations.of(context).text("password_title"),
                              state.errorCodePassword.isEmpty),
                          TextFieldWarning(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            controller: _passwordController,
                            isPassWordType: true,
                            maxLength: 20,
                            errorCode: state.errorCodePassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AppButtonWidget(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    onPressed: () {
                      hiddenKeyboard(context);
                      processor.raiseEvent(LoginButtonPressedEvent(
                          userName: _userNameController.text,
                          password: _passwordController.text));
                    },
                    title: Translations.of(context).text('login_button_text'),
                    color: const Color(0xffff8f17),
                    borderColor: const Color(0xffff8f17),
                  )
                ],
              ),
            )),
      ),
      if (state.isLoading) LoadingIndicatorWidget(),
    ]));
  }

  Widget _viewHeader(String title, bool notShowWarning) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
      child: RequireIndicatorLabelWidget(
        title: title,
        notShowWarning: notShowWarning,
      ),
    );
  }

  @override
  LoginDataState initScreenState() {
    return const LoginDataState.init();
  }
}
