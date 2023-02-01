import 'dart:async';

import 'package:encrypt_db/encrypt_db_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _encryptDbPlugin = EncryptDb();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      platformVersion =
          await _encryptDbPlugin.getPlatformVersion() ??
              'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    try {
      await _encryptDbPlugin.initializeEncryptDb();
    } on PlatformException {
      platformVersion = 'Failed to initialize encrypt db.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Center(
                child:
                    Text('Running on: $_platformVersion\n'),
              ),
              ElevatedButton(
                  onPressed: () {
                    _encryptDbPlugin.writeData(
                      key: 'first_key2',
                      value: 'I am Debojyoti',
                    );
                  },
                  child: const Text('Write data')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final value =
                      await _encryptDbPlugin.readData(
                    key: 'first_key2',
                    defaultValue: '',
                  );
                  debugPrint('value: $value');
                },
                child: const Text('Read data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
