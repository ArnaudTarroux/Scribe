import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scribe/http/router/route.dart';
import 'package:scribe/http/server.dart';
import 'package:scribe/http/router/router.dart' as Http;
import 'package:scribe/http/handler/dump_handler.dart';
import 'package:scribe/service/dump/dump_stream_service.dart';

Future main() async {
  StreamController dumpStreamController = new StreamController<String>();
  DumpStreamService dumpStreamService = new DumpStreamService(
      dumpStreamController
  );
  runApp(MyApp(dumpStreamController));
  final router = new Http.Router();
  
  router.bind(new RegExp(r'^/dump|/(\d+)$'))
    .method(Method.POST)
    .to(DumpHandler(dumpStreamService));
  
  runServer(Server.create(port: 3030, router: router));
}

class MyApp extends StatefulWidget {
  StreamController _dumpStreamController;

  MyApp(StreamController dumpStreamController) {
    this._dumpStreamController = dumpStreamController;
  }

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RawKeyboardListener(
        autofocus: true,
        focusNode: FocusNode(),
        onKey: (event) {
          print(event.physicalKey);
          if (event.isAltPressed) {
            print("ploooop");
          }
        },

        child: Scaffold(
          body: StreamBuilder(
            stream: widget._dumpStreamController.stream,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data);
              }
                return Text("wait...");
            },
          )
        )
      )
    );
  }
}