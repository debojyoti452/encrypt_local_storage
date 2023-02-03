import 'dart:async';

import 'package:encrypt_db/encrypt_db.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _encryptDbPlugin = EncryptDb();

  @override
  void initState() {
    super.initState();
    initialDb();
  }

  Future<void> initialDb() async {
    try {
      _encryptDbPlugin.initializeEncryptDb();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Encrypt DB example app'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _encryptDbPlugin.writeData(
                      key: 'secret_key',
                      value: 'secret_value',
                    );
                  },
                  child: const Text('Write data')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final value =
                      await _encryptDbPlugin.readData(
                    key: 'secret_key',
                    defaultValue: 'default_value',
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
