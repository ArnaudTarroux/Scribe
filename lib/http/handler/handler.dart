import 'dart:io';

abstract class Handler {
  Future<void> handle(HttpRequest request);
}