import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:scribe/http/handler/handler.dart';
import 'package:scribe/service/dump/dump_stream_service.dart';

class DumpHandler extends Handler {
  DumpStreamService _dumpStreamService;

  DumpHandler(DumpStreamService dumpStreamService) {
    this._dumpStreamService = dumpStreamService;
  }


  @override
  Future<void> handle(HttpRequest request) async {

    var content = await request
        .cast<List<int>>()
        .transform(Utf8Decoder())
        .join();
  
    this._dumpStreamService.send(content);
  }
}