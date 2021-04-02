import 'package:flutter_bloc_wrapper/flutter_bloc_wrapper.dart';

class AppDataState extends ScreenDataState {
  final AppState state;

  const AppDataState({this.state});

  AppDataState copy({AppState newState}) =>
      AppDataState(state: newState ?? state);

  AppDataState.init(): state = AppState.uninitialized;
}

enum AppState { uninitialized, authenticated, unauthenticated}
