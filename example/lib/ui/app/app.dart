import 'package:example_flutter_bloc_wrapper/ui/app/app_data_state.dart';
import 'package:example_flutter_bloc_wrapper/ui/app/app_event.dart';
import 'package:example_flutter_bloc_wrapper/ui/app/app_event_processor.dart';
import 'package:example_flutter_bloc_wrapper/ui/app/translation.dart';
import 'package:example_flutter_bloc_wrapper/ui/home_screen/home_screen.dart';
import 'package:example_flutter_bloc_wrapper/ui/login/login_screen.dart';
import 'package:example_flutter_bloc_wrapper/ui/splash/splash_screen.dart';
import 'package:example_flutter_bloc_wrapper/ui/view_common/loading_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_wrapper/flutter_bloc_wrapper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

AppEventProcessor appEventProcessor;

class App extends CoreScreen<AppEvent, AppDataState, AppEventProcessor> {
  @override
  Widget buildScreen(
      BuildContext context, AppEventProcessor processor, AppDataState state) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ja'),
      ],
      home: _getScreen(state),
    );
  }

  @override
  AppEventProcessor createEventProcessor(AppDataState state) {
    appEventProcessor = AppEventProcessor(state);
    appEventProcessor.raiseEvent(AppStarted());
    return appEventProcessor;
  }

  @override
  void handleDataStateChange(
      BuildContext context, AppEventProcessor processor, AppDataState state) {}

  Widget _getScreen(AppDataState appDataState) {
    switch (appDataState.state) {
      case AppState.uninitialized:
        return SplashScreen();
      case AppState.authenticated:
        return HomeScreen();
      case AppState.unauthenticated:
        return LoginScreen();
      default:
        return LoadingIndicatorWidget();
    }
  }

  @override
  AppDataState initScreenState() {
    return const AppDataState(state: AppState.uninitialized);
  }
}
