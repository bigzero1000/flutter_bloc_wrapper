import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_wrapper/src/screen_event.dart';
import 'package:flutter_bloc_wrapper/src/screen_state.dart';

abstract class EventToStateProcessor<E extends ScreenEvent, S extends ScreenDataState>
    extends Bloc<E, S> {

  EventToStateProcessor(S initialState) : super(initialState);

  S get currentState => state;

  @override
  Stream<S> mapEventToState(
    E event,
  ) {
    return processEvent(event);
  }

  Stream<S> processEvent(E event);

  void raiseEvent(E event) {
    add(event);
  }
}

