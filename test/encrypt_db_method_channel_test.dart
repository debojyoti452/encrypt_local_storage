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

import 'package:dart_std/dart_std.dart';
import 'package:encrypt_db/src/constants/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'encrypt_db_test.dart';

void main() {
  MockEncryptDbPlatform platform = MockEncryptDbPlatform();
  const MethodChannel channel =
      MethodChannel(AppConstants.CHANNEL_NAME);

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler(
        (MethodCall methodCall) async {
      switch (methodCall.method) {
        case AppConstants.METHOD_READ_ALL:
          return platform.readAll();
        case AppConstants.METHOD_READ_DATA:
          return platform.read(
              key: methodCall.arguments['key'],
              defaultValue:
                  methodCall.arguments['defaultValue']);
        case AppConstants.METHOD_WRITE_DATA:
          return platform.write(
              key: methodCall.arguments['key'],
              value: methodCall.arguments['value']);
        case AppConstants.METHOD_DELETE:
          return platform.clear(
              key: methodCall.arguments['key']);
        case AppConstants.METHOD_CLEAR_ALL:
          return platform.clearAll();
        default:
          return;
      }
    });
  });

  test('positive read all data', () async {
    platform.write(key: 'key1', value: 'value1');
    expect(await platform.readAll(),
        const Pair<String, dynamic>('key1', 'value1'));
  });

  test('negative read all data', () async {
    platform.clearAll();
    expect(await platform.readAll(), null);
  });

  test('write data tests', () async {
    platform.write(key: 'key1', value: 'value1');
    expect(
        await platform.read(key: 'key1', defaultValue: ''),
        'value1');
  });

  test('clear specific key', () async {
    platform.write(key: 'key2', value: 'value2');
    expect(
        await platform.read(
            key: 'key2', defaultValue: 'default'),
        'value2');
    await platform.clear(key: 'key2');
    expect(
        await platform.read(
            key: 'key2', defaultValue: null),
        null);
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });
}
