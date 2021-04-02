import 'package:connectivity/connectivity.dart';
import 'package:example_flutter_bloc_wrapper/data/api/api_exception.dart';
import 'package:example_flutter_bloc_wrapper/domain/pojo/user.dart';
import 'package:http/http.dart' as http;
import 'package:http_logger/logging_middleware.dart';
import 'package:http_middleware/http_with_middleware.dart';
import 'api.dart';

typedef ParseDataFunction<T> = T Function(http.Response response);

class ApiImpl implements Api {
  static const int httpStatusOk = 200;
  static const int httpStatusUnauthenticated = 401;

  final HttpWithMiddleware _httpClient = HttpWithMiddleware.build(middlewares: [
    HttpLogger(),
  ]);

  final Connectivity connectivity = Connectivity();

  Future<bool> isConnected() async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  @override
  Future<User> authenticate({String userName, String password}) async {
    final fakeUser = User(
      id: "1",
      token: "9c47f9b360375a36cceaac577d052d23",
    );
    return Future.delayed(const Duration(seconds: 2), () => fakeUser);
  }

  Future<T> callApi<T>(Future<http.Response> apiResponse,
      ParseDataFunction<T> parseDataFunction) async {
    if (!await isConnected()) {
      throw ApiException.noInternet();
    }
    final respond = await apiResponse.catchError((error) {
      throw ApiException.withMessage(message: error.toString());
    });
    return handleRespond(respond, parseDataFunction);
  }

  T handleRespond<T>(
      http.Response response, ParseDataFunction<T> parseDataFunction) {
    switch (response.statusCode) {
      case httpStatusOk:
        try {
          return parseDataFunction.call(response);
        } catch (error) {
          throw ApiException.withMessage(message: error.toString());
        }
        break;
      default:
        throw ApiException.unknown();
    }
  }

// @override
// Future<List<Pokemon>> getPokemons(int offset, int limit) {
//   final url = "$webApiBaseUrl/pokemon?offset=$offset&limit=$limit";
//   final apiResponse = _httpClient.get(url);
//   debugPrint("aaaa url:  $url");
//   return callApi(
//       apiResponse,
//       (response) => ((jsonDecode(response.body) as Map<String, dynamic>)['results'] as List)
//           ?.map((pokemonData) => Pokemon.fromJson(pokemonData as Map<String, dynamic>))
//           ?.toList());
// }
}
