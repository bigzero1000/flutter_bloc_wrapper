import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_wrapper/src/bloc_processor.dart';
import 'package:flutter_bloc_wrapper/src/screen_event.dart';
import 'package:flutter_bloc_wrapper/src/screen_state.dart';
import 'package:flutter_bloc_wrapper/src/type.dart';

abstract class CoreScreen<E extends ScreenEvent, S extends ScreenDataState,
    EP extends EventToStateProcessor<E, S>> extends StatefulWidget {
  const CoreScreen({Key key}) : super(key: key);

  /// init screen state
  S initScreenState();

  /// This method will be call whenever [processor] produce a new data state after processing received event from ui
  /// For ex: we can show dialog if new state is error data state
  /// ```
  ///	if (newState.error != null) {
  ///	  showAlertDialog(context, Text(state.error.message));
  ///	}
  ///	```
  void handleDataStateChange(BuildContext context, EP processor, S state);

  /// Create & return `EventToStateProcessor` instance for use in this widget or its child. For ex:
  /// ```return LoginEventProcessor();```
  EP createEventProcessor(S state);

  /// This method for build screen ui base on current data state. For ex: if state is `state.isLoading` is true then show ProgressBar
  ///	```if (state.isLoading) LoadingIndicatorWidget() else Container()```
  Widget buildScreen(BuildContext context, EP processor, S state);

  /// callback when init state screen
  void initScreen() {}

  /// callback when dispose state screen
  void disposeScreen() {}

  @override
  _CoreScreenState createState() =>
      _CoreScreenState<E, S, EP>(createEventProcessor(initScreenState()));
}

class _CoreScreenState<E extends ScreenEvent, S extends ScreenDataState,
    EP extends EventToStateProcessor<E, S>> extends State<CoreScreen> {
  final EP _createBloc;

  _CoreScreenState(this._createBloc);

  @override
  void initState() {
    widget.initScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EP>(
      create: (ctx) => _createBloc,
      child: _ScreenContentWidget<E, S, EP>(
        widget.handleDataStateChange,
        widget.buildScreen,
      ),
    );
  }

  @override
  void dispose() {
    widget.disposeScreen();
    super.dispose();
  }
}

class _ScreenContentWidget<E extends ScreenEvent, S extends ScreenDataState,
    EP extends EventToStateProcessor<E, S>> extends StatefulWidget {
  const _ScreenContentWidget(
    DataStateChangeHandler<E, S, EP> dataStateChangeHandler,
    ScreenContentBuilder<E, S, EP> screenContentBuilder, {
    Key key,
  })  : assert(
          dataStateChangeHandler != null,
          'A non-null screen ui content builder must be provided to a this widget.',
        ),
        assert(
          screenContentBuilder != null,
          'A non-null date state change handler function must be provided to a Text widget.',
        ),
        _dataStateChangeHandler = dataStateChangeHandler,
        _screenContentBuilder = screenContentBuilder,
        super(key: key);

  final DataStateChangeHandler<E, S, EP> _dataStateChangeHandler;
  final ScreenContentBuilder<E, S, EP> _screenContentBuilder;

  @override
  _CoreWidgetStateState createState() {
    return _CoreWidgetStateState<E, S, EP>();
  }
}

class _CoreWidgetStateState<E extends ScreenEvent, S extends ScreenDataState,
        EP extends EventToStateProcessor<E, S>>
    extends State<_ScreenContentWidget> {
  EP _eventProcessor;

  @override
  void initState() {
    _eventProcessor = BlocProvider.of<EP>(context);
    super.initState();
  }

  void raiseEvent(E event) {
    _eventProcessor.raiseEvent(event);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen args here for init screen's variable value;
    // Listen for state change and build screen ui
    return BlocListener<EP, S>(
        bloc: _eventProcessor,
        listener: (context, state) {
          widget._dataStateChangeHandler.call(context, _eventProcessor, state);
        },
        child: BlocBuilder(
            bloc: _eventProcessor,
            builder: (context, state) {
              return widget._screenContentBuilder
                  .call(context, _eventProcessor, state as S);
            }));
  }
}
