import 'package:example_flutter_bloc_wrapper/ui/app/app_data_state.dart';
import 'package:example_flutter_bloc_wrapper/ui/app/app_event.dart';
import 'package:flutter_bloc_wrapper/flutter_bloc_wrapper.dart';

class AppEventProcessor extends EventToStateProcessor<AppEvent, AppDataState> {
  AppEventProcessor(AppDataState initialState) : super(initialState);

  @override
  Stream<AppDataState> processEvent(AppEvent event) async* {
    if (event is AppStarted) {
      await Future.delayed(const Duration(milliseconds: 2000));
      yield currentState.copy(newState: AppState.unauthenticated);
    }
    if (event is LoggedIn) {
      yield currentState.copy(newState: AppState.authenticated);
    }
  }
}
