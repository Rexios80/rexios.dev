import 'dart:io';
import 'package:jaguar/jaguar.dart';
import 'package:jaguar_cors/jaguar_cors.dart';
import 'package:jaguar_dev_proxy/jaguar_dev_proxy.dart';

const corsOptions = CorsOptions(
  allowAllOrigins: true,
  allowAllMethods: true,
  allowAllHeaders: true,
  allowCredentials: true,
  allowNonCorsRequests: true,
  vary: true,
);

void main(List<String> arguments) async {
  final port = Platform.environment.containsKey('PORT')
      ? int.parse(Platform.environment['PORT']!)
      : 8080;

  final server = Jaguar(port: port);
  server.addRoute(
    getOnlyProxy(
      '/pub/*',
      'http://pub.dartlang.org',
    )..after(cors(corsOptions)),
  );
  server.log.onRecord.listen(print);
  await server.serve(logRequests: true);
}
