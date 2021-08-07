import 'package:scribe/http/handler/handler.dart';
import 'package:scribe/http/router/NotFoundException.dart';
import 'package:scribe/http/router/route.dart';

class Router {
  static Map<RegExp, Route> _routes = Map();
  Map<RegExp, Route> get routes => _routes;

  Route bind(RegExp path) {
    final route = new Route(path);
    _routes[path] = route;

    return route;
  }

  Handler match(String path, String method) {
    try {
      final route = this.routes.entries.firstWhere((element) => element.value.isSatisfiedBy(path, method));

      return route.value.handler;
    } catch (e) {
      throw new NotFoundException();
    }
  }
}