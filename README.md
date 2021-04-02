# flutter_bloc_wrapper

## Getting Started

This package is use to develop app which use Bloc pattern clearer, quicker, easier by wrapping complicated bloc usage.

### Usage
#### Using ProcessorProvider instead of BlockProvider for providing
	+ event processor instance or
	+ create processor instance for use in child widget.

Example:
```
void main() {
	 runApp(
		 ProcessorProvider<AuthenticationEventProcessor>(
			 create: (BuildContext context) => AuthenticationEventProcessor(),
			 child: const App(),
		 ),
	 );
 }
 ```
#### Implement screen widget
1. Create State extends ScreenDataState class. For ex: LoginScreenState
2. Create Event extends ScreenEvent class. For ex: LoginScreenEvent
3. Create Login screen and implement 4 function
	``
class LoginScreen
    extends CoreScreen<LoginScreenEvent, LoginScreenState, LoginEventProcessor>
``
	3.1 `handleDataStateChange`: handle state change after processor handle event and change widget state. For ex: press login button --> process by processor --> processor change state to LoginFailure because of invalid of login data so we want to show Alert dialog for example, do it in this function.
	```
	if (newState.error != null) {
	  showAlertDialog(context, Text(state.error.message));
	}
	```
	3.2 `createEventProcessor(State state)`: return `EventToStateProcessor` for use in this widget or its child. For ex just:
		```return LoginEventProcessor(state);```
	3.3 `initScreenState`: state of screen when initial
	```if (state.isLoading) LoadingIndicatorWidget() else Container()```
	3.4 `buildScreen`: for build screen ui base on data state. For ex: if state is `state.isLoading` is true then show ProgressBar

    	```if (state.isLoading) LoadingIndicatorWidget() else Container()```
   3.5	Other 2 method `initScreen` and `disposeScreen` 2 call back when init state screen and dispose state of Screen.

## Dart Versions

- Dart 2: >= 2.8.0

## Maintainers

- [bigzero1000](https://github.com/bigzero1000)

## License
[MIT](https://choosealicense.com/licenses/mit/)



