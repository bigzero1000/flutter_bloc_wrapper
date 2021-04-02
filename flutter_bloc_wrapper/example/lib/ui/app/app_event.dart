import 'package:flutter_bloc_wrapper/flutter_bloc_wrapper.dart';

abstract class AppEvent extends ScreenEvent {
  const AppEvent();
}

/// An AppStarted event to notify the bloc that it needs to check if the user is currently authenticated or not.
class AppStarted extends AppEvent {}

/// A LoggedIn event to notify the bloc that the user has successfully logged in.
class LoggedIn extends AppEvent {}

/// A LoggedOut event to notify the bloc that the user has successfully logged out.
class LoggedOut extends AppEvent {}

