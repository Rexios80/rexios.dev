import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_proxy/shelf_proxy.dart';
import 'package:shelf_router/shelf_router.dart';

final pubHandler = Pipeline()
    .addMiddleware(
      corsHeaders(
        originChecker:
            originOneOf(['https://rexios.dev', 'https://beta.rexios.dev']),
      ),
    )
    .addHandler(
      proxyHandler('https://pub.dartlang.org', proxyName: 'proxy.rexios.dev'),
    );

final overseerrHandler = Pipeline().addHandler(
  proxyHandler('http://bull.seedhost.eu:14499', proxyName: 'proxy.rexios.dev'),
);

void main(List<String> arguments) async {
  final app = Router()
    ..mount('/pub', pubHandler)
    ..mount('/overseerr', overseerrHandler);

  final port = Platform.environment.containsKey('PORT')
      ? int.parse(Platform.environment['PORT']!)
      : 8080;
  final server = await shelf_io.serve(app, '0.0.0.0', port);

  print('Listening on :${server.port}');
}
