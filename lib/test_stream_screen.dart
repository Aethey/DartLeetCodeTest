import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class TestStreamScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TestStreamState();
}

class TestStreamState extends State<TestStreamScreen> {
  StreamController<String> _streamController;
  Sink _sink;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<String>();
    _sink = _streamController.sink;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            String data = Random().nextInt(100).toString();
            _sink.add('event$data');
          },
          icon: Icon(Icons.ac_unit),
        ),
      ),
      body: StreamBuilder(
        stream: _streamController.stream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Text('${snapshot.data.toString()}'),
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _sink.close();
    _streamController.close();
  }
}
