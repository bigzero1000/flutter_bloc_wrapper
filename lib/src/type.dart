import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_wrapper/src/bloc_processor.dart';
import 'package:flutter_bloc_wrapper/src/screen_event.dart';
import 'package:flutter_bloc_wrapper/src/screen_state.dart';

typedef DataStateChangeHandler<E extends ScreenEvent, S extends ScreenDataState,
        EP extends EventToStateProcessor<E, S>>
    = void Function(BuildContext context, EP processor, S state);

typedef ScreenContentBuilder<E extends ScreenEvent, S extends ScreenDataState,
        EP extends EventToStateProcessor<E, S>>
    = Widget Function(BuildContext context, EP processor, S state);
