import 'dart:io';
import 'package:meta/meta.dart';
import 'package:scribe/http/router/NotFoundException.dart';
import 'package:scribe/http/router/router.dart';

class Server {
  int _port;
  Router _router;

  Server._(int port, Router router) {
    this._port = port;
    this._router = router;
  }

  static Server create({int port = 3030, @required Router router}) {
    return Server._(port, router);
  }
}

void runServer(Server server) async {
  print("Server run on port: " + server._port.toString());

  final httpServer = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    server._port,
  );
  print('Listening on http://${httpServer.address.address}:${httpServer.port}/');

  await for (HttpRequest request in httpServer) {
    try {
      var handler = server._router.match(request.uri.path, request.method);
      handler.handle(request);
      await request.response.close();
    } on NotFoundException {
      request.response.statusCode = 404;
      request.response.write('Not found');
      await request.response.close();
    }
  }
}