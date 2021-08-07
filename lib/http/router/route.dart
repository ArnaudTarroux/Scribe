import 'package:scribe/http/handler/handler.dart';

enum Method {
  GET,
  POST,
  DELETE,
  PUT,
  OPTION
}

class Route {
  RegExp _path;
  Handler _handler;
  Method _method;

  Handler get handler => _handler;

  Route(RegExp path) {
    this._path = path;
  }

  Route method(Method method) {
    this._method = method;

    return this;
  }

  Route to(Handler handler) {
    this._handler = handler;

    return this;
  }

  bool isSatisfiedBy(String path, String method) {
    return this._path.hasMatch(path) && method == this._method.toString().split(".")[1];
  }
}