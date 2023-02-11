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
import 'package:encrypt_db/encrypt_db.dart';
import 'package:encrypt_db/src/core/encrypt_db_method_channel.dart';
import 'package:encrypt_db/src/core/encrypt_db_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEncryptDbPlatform
    with MockPlatformInterfaceMixin
    implements EncryptDbPlatform {
  Pair<String, dynamic>? _pairData =
      const Pair<String, dynamic>('', '');

  @override
  void initializeEncryptDb({
    EncryptInformationModel? encryptInformationModel,
  }) {}

  @override
  Future read<T>({
    required String key,
    required T defaultValue,
  }) {
    return Future.value(_pairData?.second);
  }

  @override
  void write<T>({
    required String key,
    required T value,
  }) {
    if (T == String) {
      _pairData = Pair(key, value as String);
    } else if (T == int) {
      _pairData = Pair(key, value as int);
    } else if (T == double) {
      _pairData = Pair(key, value as double);
    } else if (T == bool) {
      _pairData = Pair(key, value as bool);
    }
  }

  @override
  Future<dynamic> clearAll() {
    _pairData = null;
    return Future.value(_pairData);
  }

  @override
  Future<dynamic> clear({required String key}) {
    if (_pairData?.first == key) {
      _pairData = null;
      return Future.value(_pairData);
    }
    return Future.value(_pairData);
  }

  @override
  Future<dynamic> readAll() {
    if (_pairData?.first.isEmpty ?? false) {
      return Future.value(null);
    }
    return Future.value(_pairData);
  }
}

void main() {
  final EncryptDbPlatform initialPlatform =
      EncryptDbPlatform.instance;

  test('$MethodChannelEncryptDb is the default instance',
      () {
    expect(initialPlatform,
        isInstanceOf<MethodChannelEncryptDb>());
  });

  test('positive write test', () async {
    EncryptDb encryptDbPlugin = EncryptDb();
    MockEncryptDbPlatform fakePlatform =
        MockEncryptDbPlatform();
    EncryptDbPlatform.instance = fakePlatform;
    encryptDbPlugin.write(key: 'key', value: 'value1');
    var data = await encryptDbPlugin.read(
        key: 'key', defaultValue: 'value');
    expect(data, 'value1');
  });

  test('negative write test', () async {});
}
