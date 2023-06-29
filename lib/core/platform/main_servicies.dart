import 'package:comicbookapp/core/network/http_client.dart';
import 'package:comicbookapp/core/network/network_info.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

class MainServices {
  Future<void> init() async {
    await dotenv.load(fileName: ".env");

    final connection = NetworkInfoImpl();

    GetIt.instance.registerSingleton<NetworkInfo>(connection);

    GetIt.instance.registerSingleton<HttpClient>(HttpClientImpl(
      connection: connection,
      apiKey: dotenv.env['API_KEY']!,
    ));
  }
}
