/*
 * *
 *  * * MIT License
 *  * *******************************************************************************************
 *  *  * Created By Debojyoti Singha
 *  *  * Copyright (c) 2023.
 *  *  * Permission is hereby granted, free of charge, to any person obtaining a copy
 *  *  * of this software and associated documentation files (the "Software"), to deal
 *  *  * in the Software without restriction, including without limitation the rights
 *  *  * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  *  * copies of the Software, and to permit persons to whom the Software is
 *  *  * furnished to do so, subject to the following conditions:
 *  *  *
 *  *  * The above copyright notice and this permission notice shall be included in all
 *  *  * copies or substantial portions of the Software.
 *  *  *
 *  *  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  *  * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  *  * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  *  * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  *  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  *  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  *  * SOFTWARE.
 *  *  * Contact Email: support@swingtechnologies.in
 *  * ******************************************************************************************
 *
 */

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
  final Map<String, dynamic> _testPrintMap =
      <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    initialDb();
  }

  Future<void> initialDb() async {
    try {
      _encryptDbPlugin.initializeEncryptDb();
      _encryptDbPlugin.write(key: 'key0', value: 452);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _runManualTest() async {
    try {
      var result = await _encryptDbPlugin.readAll();
      debugPrint('result0: $result');
      _testPrintMap['result0'] = result;
      await _encryptDbPlugin.clearAll();
      debugPrint('Clear all');
      result = await _encryptDbPlugin.readAll();
      debugPrint('result1: $result');
      _testPrintMap['result1'] = result;
      _encryptDbPlugin.write(key: 'key1', value: 'value1');
      debugPrint('Write key1');
      _testPrintMap['Write key1'] = 'Write key1';
      result = await _encryptDbPlugin.read(
          key: 'key1', defaultValue: 'default_value');
      debugPrint('result2: $result');
      _testPrintMap['result2'] = result;
      _encryptDbPlugin.write(key: 'key2', value: 'value2');
      debugPrint('Write key2');
      _testPrintMap['Write key2'] = 'Write key2';
      result = await _encryptDbPlugin.readAll();
      debugPrint('result3: $result');
      _testPrintMap['result3'] = result;
      _encryptDbPlugin.clear(key: 'key1');
      debugPrint('Delete key1');
      _testPrintMap['Delete key1'] = 'Delete key1';
      result = await _encryptDbPlugin.readAll();
      debugPrint('result4: $result');
      _testPrintMap['result4'] = result;
      _encryptDbPlugin.clearAll();
      debugPrint('Clear all');
      _testPrintMap['Clear all'] = 'Clear all';
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      debugPrint('Test print map: $_testPrintMap');
      setState(() {});
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: _testPrintMap.length,
                itemBuilder:
                    (BuildContext context, int index) {
                  final key =
                      _testPrintMap.keys.elementAt(index);
                  final value = _testPrintMap[key];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    child: Text('log: $key: $value'),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  _runManualTest();
                },
                child: const Text('Run Test'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
